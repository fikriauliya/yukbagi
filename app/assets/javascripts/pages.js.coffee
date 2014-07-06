# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

pageServices = angular.module('pageServices', ['ngResource']);
pageServices.factory "Group", [
  "$resource"
  ($resource) ->
    return $resource("profiles/:profile_id/groups/:group_id/.json", {profile_id: gon.profile_id});
]
pageServices.factory "Lesson", [
  "$resource"
  ($resource) ->
    return $resource("profiles/:profile_id/groups/:group_id/lessons/:lesson_id.json", {profile_id: gon.profile_id});
]

myApp = angular.module('myApp', ['pageServices'])
myApp.controller('PageCtrl', [
  '$scope', 'Group', 'Lesson',
  ($scope, Group, Lesson) ->

    $scope.createGroup = () ->
      console.log("New group")

      $scope.newGroup.$save(
        (u, header) ->
          console.log("Saved, close modal")
          $('#newGroupModal').modal('hide')

          $scope.refreshGroup()
      );

    $scope.selectGroup = (group) ->
      console.log("Group selected:")
      console.log(group)
      $scope.selectedGroup = group

      $scope.refreshLessons()

    $scope.createLesson = () ->
      console.log("New lesson")
      $('.selector-wrapper').addInputs($('#lesson_url').data('preview'));

#      original_url = $('input[name="original_url"').val()
      url = decodeURIComponent($('input[name="url"').val())
      type = $('input[name="type"').val()
#      provider_url = $('input[name="provider_url"').val()
#      provider_display = $('input[name="provider_display"').val()
      provider_name = decodeURIComponent($('input[name="provider_name"').val())
      favicon_url = decodeURIComponent($('input[name="favicon_url"').val())
      title = decodeURIComponent($('input[name="title"').val())
      description = decodeURIComponent($('input[name="description"').val())
      thumbnail_url = decodeURIComponent($('input[name="thumbnail_url"').val())
#      author_name = $('input[name="author_name"').val()
#      author_url = $('input[name="author_url"').val()
#      media_type = $('input[name="media_type"').val()
#      media_html = $('input[name="media_html"').val()
#      media_width = $('input[name="media_width"').val()
#      media_height = $('input[name="media_height"').val()

#      console.log('original_url' + original_url)
      console.log('url' + url)
      console.log('type' + type)
#      console.log('provider_url' + provider_url)
#      console.log('provider_display' + provider_display)
      console.log('provider_name' + provider_name)
      console.log('favicon_url' + favicon_url)
      console.log('title' + title)
      console.log('description' + description)
      console.log('thumbnail_url' + thumbnail_url)
#      console.log('author_name' + author_name)
#      console.log('author_url' + author_url)
#      console.log('media_type' + media_type)
#      console.log('media_html' + media_html)
#      console.log('media_width' + media_width)
#      console.log('media_height' + media_height)

      $scope.newLesson.external_url = url
      $scope.newLesson.tyoe = type
      $scope.newLesson.provider_name = provider_name
      $scope.newLesson.favicon_url = favicon_url
      $scope.newLesson.title = title
      $scope.newLesson.description = description
      $scope.newLesson.thumbnail_url = thumbnail_url

      $scope.newLesson.$save({group_id: $scope.selectedGroup.id},
        (u, header) ->
          console.log("Saved, close modal")
          $('#newLessonModal').modal('hide')

          $scope.refreshGroupCounter($scope.selectedGroup)
          $scope.refreshLessons()
      )

    $scope.refreshGroup = () ->
      if ($scope.selectedGroup)
        selectedGroupIndex = $scope.groups.indexOf($scope.selectedGroup)
      else
        selectedGroupIndex = null

      $scope.groups = Group.query(
        () ->
          console.log($scope.groups)
          if (selectedGroupIndex)
            $scope.selectGroup($scope.groups[selectedGroupIndex])
          else
            if ($scope.groups.length > 0)
              # by default, select the first one
              $scope.selectGroup($scope.groups[0])
      )

    $scope.refreshLessons = () ->
      $scope.lessons = Lesson.query({profile_id: gon.profile_id, group_id: $scope.selectedGroup.id})

    $scope.refreshGroupCounter = (group) ->
      newGroupInfo = Group.get({group_id : group.id},
        () ->
          group.lessons_count = newGroupInfo.lessons_count
      )

    $scope.newGroup = new Group()
    $scope.newLesson = new Lesson()
    $scope.selectedGroup = null
    $scope.refreshGroup()

    $('#lesson_url').preview({key:'635853e17b764c629a82aa3628f949d5'})
])