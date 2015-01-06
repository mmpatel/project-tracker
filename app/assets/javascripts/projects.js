$(document).ready(function(){
    projectBorad();
});

function projectBorad() {
  $("#section-block").sortable({
    connectWith: ".workflowSortable",
    update: function(event, ui){
      var workflow_positions = $('.workflowSortable').serialize_workflow();
      var params = {}
      params["work_flows"] = workflow_positions
      $.ajax({
        url: '/workflows/sort',
        data: params,
        type: "post"
        }).done(function() {
      });
    }
  }).disableSelection();
  $("ul.issueSortable").sortable({
      connectWith: ".issueSortable",
      update: function(event, ui) {
        var issues_positions = $('.issueSortable').serialize_issue();
        var params = {}
        params["work_flows"] = issues_positions
        $.ajax({
          url: '/issues/sort',
          data: params,
          type: "post"
          }).done(function() {
        });
      }
  }).disableSelection();

  $.fn.serialize_issue = function() {
    var workflows = {};
    var $elem = $(this);
    $elem.each(function(i) {
      var menu = this.id;
      var issues = {}
      $('li', this).each(function(e) {
        if(this.id)
          issues[e] = this.id
      });
      workflows[menu] = issues
    });
    return workflows;
  }
  $.fn.serialize_workflow = function() {
    var workflowpositions = [];
    var $elem = $(this);
    $elem.each(function(i) {
      workflowpositions.push(this.id)
    });
    return workflowpositions;
  }

  $( ".catalog li" ).draggable({
    appendTo: "body",
    helper: "clone"
  });

  $( ".cart" ).droppable({
    accept: ":not(.ui-sortable-helper)",
    drop: function( event, ui ) {
      $("<span></span>").text(ui.draggable.text()).attr('class', ui.draggable[0].id).appendTo( this );
      var users_positions = $('.cart').update_user();
      var params = {}
      params["users"] = users_positions
      $.ajax({
        url: '/projects/updateuser',
        data: params,
        type: "post"
        }).done(function() {

      });
    }
  }).sortable({
    items: "li:not(.placeholder)",
    sort: function() {
      $( this ).removeClass( "ui-state-default" );
    }
  });

  $.fn.update_user = function() {
    var issues = {};
    var $elem = $(this);
    $elem.each(function(i) {
      var menu = this.id
      var users = {};
      $('span', this).each(function(e) {
          var className = $(this).attr('class');
          issues[menu] = className
      });
    });
    return issues
  }
}

