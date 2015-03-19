angular.module('controllers').controller("UIRecipesListCtrl",
  ['$scope', '$stateParams', '$location','$state', '$resource', 'Recipe'
    ($scope, $stateParams, $location,$state, $resource, Recipe)->

      $scope.search = (keywords)->
        $location.search('keywords', keywords)

      if $stateParams.keywords
        Recipe.query(keywords: $stateParams.keywords, (results)-> $scope.recipes = results)
      else
        $scope.recipes = Recipe.query({}, (results)-> $scope.recipes = results)
  ])