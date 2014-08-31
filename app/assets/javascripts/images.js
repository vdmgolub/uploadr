$(function() {
  $('#s3-uploader').S3Uploader({
    remove_failed_progress_bar: true,
    allow_multiple_files: false
  });
  $('#s3-uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload: ' + content.error_thrown);
  });
});
