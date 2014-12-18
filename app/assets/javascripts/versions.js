diff_match_patch.prototype.diff_tosbackHtml = function(diffs) {
  var html = [];
  var pattern_amp = /&/g;
  var pattern_lt = /</g;
  var pattern_gt = />/g;
  var pattern_para = /\n/g;
  for (var x = 0; x < diffs.length; x++) {
    var op = diffs[x][0];    // Operation (insert, delete, equal)
    var data = diffs[x][1];  // Text of change.
    var text = data;
    //var text = data.replace(pattern_amp, '&amp;').replace(pattern_lt, '&lt;')
        //.replace(pattern_gt, '&gt;').replace(pattern_para, '&para;<br>');
    switch (op) {
      case DIFF_INSERT:
        html[x] = '<ins class="diff">' + text + '</ins>';
        break;
      case DIFF_DELETE:
        html[x] = '<del class="diff">' + text + '</del>';
        break;
      case DIFF_EQUAL:
        html[x] = '<span>' + text + '</span>';
        break;
    }
  }
  return html.join('');
};

$(function(){
  TosbackDiffHandler.init();

  $(".version_link").bind('ajax:success', function(evt, status, data, xhr){
    
    if (evt.target.dataset.diffLink == "true") {
      //console.log("difffffffffff");
      window.TosbackDiffHandler.showDiff(status);
    } else {
      window.TosbackDiffHandler.showPolicy(status);
    };

    //console.log(status.text);
  });
});

var TosbackDiffHandler = {
  init: function(){
    // TODO #policy_text only exists on policy page
    this.currentVersion = $("#policy_text").html().trim();
    this.dmp = new diff_match_patch();
    //console.log("init");
  },
  showDiff: function(diff_version){
    //console.log("showDiff");
    this.diff = this.dmp.diff_main(this.currentVersion, diff_version.text);
    this.dmp.diff_cleanupSemantic(this.diff);

    $("#policy_diff").html(this.dmp.diff_tosbackHtml(this.diff));
    $("#date_text").html("Diff with " + diff_version.created_at );
    $("#policy_text").hide();
    $("#policy_diff").show();
  },
  showPolicy: function(policy){
    if (policy != undefined) {
      this.currentVersion = policy.text;
      $("#policy_text").html(policy.text);
      $("#date_text").html("ToSBack stored this version on " + policy.created_at );
    }

    $("#policy_diff").hide();
    $("#policy_text").show();
  }
};
