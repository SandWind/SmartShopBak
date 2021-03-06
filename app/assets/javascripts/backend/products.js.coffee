# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $.fn.select2
    $("#product_option_type_ids").select2()

  if $("#epiceditor").length > 0
    opts =
      basePath: "/assets/"
      theme:
        base: "markdown/epiceditor.css"
        preview: "markdown/bartik.css"
        editor: "markdown/epic-light.css"
      button: false
      clientSideStorage: false

    editor = new EpicEditor(opts).load()
    editor.getElement('editor').body.innerHTML = $("#product_detail").val()

    attachEditModeHandler = ->
      editor.edit()
    attachPreviewModeHandler = ->
      editor.preview()

    $(document).on 'click', '#editor-edit-btn', attachEditModeHandler
    $(document).on 'click', '#editor-preview-btn', attachPreviewModeHandler

  if $("#submit_prodcut_epiceditor").length > 0
    attachSaveProductDetail = ->
      $("#product_detail").val(editor.getElement('editor').body.innerHTML)
    $(document).on 'click', '#submit_prodcut_epiceditor', attachSaveProductDetail


  if $("#editor-preview-btn").length > 0
    appendImageFromUpload = (srcs) ->
      src_merged = ""
      for src in srcs
        src_merged = "![](#{src.image.url})<br />"
      source = editor.getElement('editor').body.innerHTML
      editor.getElement('editor').body.innerHTML = source + src_merged
      editor.focus()

  if $("#product_upload_images").length > 0
    product_id = $("#detail_add_image").data("product")

    opts =
      # url should be connection product
      url: '/admin/products/' + product_id + '/images'
      type: 'POST'
      dataType: 'json'
      beforeSend: ->
        $("#detail_add_image").hide()
        $("#uploading_image").show()
        return

      complete: ->
        $("#uploading_image").hide()
        $("#detail_add_image").show()
        return

      success: (result, status, xhr) ->
        unless result
          window.alert "Server error."
          return
        if result.image
          # window.alert "Success! You have sent a file named '" + result.image.id + "' with MIME type '" + result.image.url + "'."
          appendImageFromUpload([result])
          return

    $("#product_upload_images").fileUpload opts
    return false


attachGetOptionTypesHandler = ->
  $this = $(this)
  prototype_id = $("option:selected", $(this)).val()
  $.ajax
    type: 'GET'
    url: "/admin/prototypes/" + prototype_id
    dataType: 'script'

$(document).on 'change', '#product_prototype_id', attachGetOptionTypesHandler

attachImageUploaderHandler = ->
  $("#product_upload_images").click()

$(document).on 'click', '#detail_add_image', attachImageUploaderHandler
