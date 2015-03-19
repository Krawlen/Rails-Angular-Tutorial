controllers = angular.module('controllers')
controllers.controller("RecipesListController", ['$scope', '$routeParams', '$location', '$resource'
  ($scope, $routeParams, $location, $resource)->
    Recipe = $resource('/recipes/:recipeId', {recipeId: "@id", format: 'json'})

    $scope.search = (keywords)->
      $location.path("/").search('keywords', keywords)

    $scope.view = (recipeId)->
      $location.path("/recipes/#{recipeId}")

    $scope.newRecipe = -> $location.path("/recipes/new")
    $scope.edit = (recipeId)-> $location.path("/recipes/#{recipeId}/edit")

    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.recipes = Recipe.query({}, (results)-> $scope.recipes = results)
])