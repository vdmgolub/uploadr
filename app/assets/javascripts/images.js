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
      onChange: update_crop,
      onSelect: update_crop,
      setSelect: [0, 0, 250, 250],
      aspectRatio: 1
    });

    $('#uploader').hide();
    $('#cropper').show();
  });

  function update_crop(coords) {
    $('#crop_x').val(coords.x);
    $('#crop_y').val(coords.y);
    $('#crop_w').val(coords.w);
    $('#crop_h').val(coords.h);
  }
});
