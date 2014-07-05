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
    $scope.groups = Group.query(
      () ->
        console.log($scope.groups)
        if ($scope.groups.length > 0)
          # by default, select the first one
          $scope.selectedGroup = $scope.groups[0]
          console.log("Selected group: ")
          console.log($scope.selectedGroup)
          $scope.refreshLessons()
    )
    $scope.newGroup = new Group()
    $scope.newLesson = new Lesson()

    $scope.createGroup = () ->
      console.log("New group")

      $scope.newGroup.$save(
        (u, header) ->
          console.log("Saved, close modal")
          $('#newGroupModal').modal('hide')

          $scope.groups = Group.query()
      );

    $scope.selectGroup = (group) ->
      console.log("Group selected:")
      console.log(group)
      $scope.selectedGroup = group

      $scope.refreshLessons()

    $scope.createLesson = () ->
      console.log("New lesson")

      $scope.newLesson.$save({group_id: $scope.selectedGroup.id},
        (u, header) ->
          console.log("Saved, close modal")
          $('#newLessonModal').modal('hide')

          $scope.refreshLessons()
      )

    $scope.refreshLessons = () ->
      $scope.lessons = Lesson.query({profile_id: gon.profile_id, group_id: $scope.selectedGroup.id})
])