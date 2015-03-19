controllers = angular.module('controllers')
controllers.controller("RecipeController", [ '$scope', '$routeParams', '$resource' , 'flash',
  ($scope,$routeParams,$resource, flash)->
    Recipe = $resource('/recipes/:recipeId', { recipeId: "@id", format: 'json' })
    Recipe.get({recipeId: $routeParams.recipeId},
      (result)-> $scope.recipe = result,
      (http_response)->
        $scope.recipe = null
        flash.error = "There is no recipe with ID #{$routeParams.recipeId}")
])