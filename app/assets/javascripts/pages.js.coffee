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
])