controllers = angular.module('controllers')
controllers.controller("RecipesListController",
  ['$scope', '$stateParams', '$location', '$resource'
  ($scope, $stateParams, $location, $resource)->
    Recipe = $resource('/recipes/:recipeId', {recipeId: "@id", format: 'json'})
    $scope.search = (keywords)->
      $location.search('keywords', keywords)

    $scope.newRecipe = -> $location.path("/recipes/new")
    $scope.edit = (recipeId)-> $location.path("/recipes/#{recipeId}/edit")

    if $stateParams.keywords
      Recipe.query(keywords: $stateParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.recipes = Recipe.query({}, (results)-> $scope.recipes = results)
])