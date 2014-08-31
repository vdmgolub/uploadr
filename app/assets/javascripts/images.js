$(function() {
  $('#s3-uploader').S3Uploader({
    remove_failed_progress_bar: true,
    allow_multiple_files: false
  });
  $('#s3-uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload: ' + content.error_thrown);
  }).bind('s3_upload_complete', function(e, content) {
    $('#crop-image').attr('src', content.url);
    $('#temp_url').val(content.url);
    $('#crop-image').Jcrop({
      onChange: updateCrop,
      onSelect: updateCrop,
      setSelect: [0, 0, 250, 250],
      aspectRatio: 1
    });

    $('#uploader').hide();
    $('#cropper').show();
  });

  function updateCrop(coords) {
    var ratio = calculateRatio();
    $('#crop_x').val(coords.x * ratio);
    $('#crop_y').val(coords.y * ratio);
    $('#crop_w').val(coords.w * ratio);
    $('#crop_h').val(coords.h * ratio);
  }

  // TODO: refactor not to use DOM objects
  function calculateRatio() {
    var real_width = $('#crop-image')[0].width;
    var cropped_width = $('.jcrop-holder img')[0].width;
    return real_width / cropped_width;
  }
});
