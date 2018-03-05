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
    // TODO need access to version loaded from server initally
    this.currentVersion = {};
    this.currentVersion.id = $("#version_info").data().currentVersion;
    this.currentVersion.text = $("#policy_text").html().trim();
    this.dmp = new diff_match_patch();
    //console.log("init");
    this.updateFormatting(this.currentVersion.id);
  },
  showDiff: function(diff_version){
    //console.log("showDiff");
    this.diff = this.dmp.diff_main(this.currentVersion.text, diff_version.text);
    this.dmp.diff_cleanupSemantic(this.diff);

    $("#policy_diff").html(this.dmp.diff_tosbackHtml(this.diff));
    $("#date_text").html("Diff with " + diff_version.created_at );
    $("#policy_text").hide();
    $("#policy_diff").show();

    this.updateFormatting(diff_version.id);
  },
  showPolicy: function(policy){
    if (policy != undefined) {
      this.currentVersion = policy;
      $("#policy_text").html(this.currentVersion.text);
      $("#date_text").html("ToSBack stored this version on " + this.currentVersion.created_at );
    }

    $("#policy_diff").hide();
    $("#policy_text").show();
    this.updateFormatting(this.currentVersion.id);
  },
  updateFormatting: function(version_id){
    $(".version_link").show();
    $("#version_diff_link_" + version_id).hide();
    $("#version_diff_link_" + this.currentVersion.id).hide();
  }
};
