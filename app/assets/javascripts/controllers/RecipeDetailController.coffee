controllers = angular.module('controllers')
controllers.controller("RecipeDetailController",
  ['$scope', '$routeParams', '$resource', '$location', 'flash',
    ($scope, $routeParams, $resource, $location, flash)->
      $scope.back = -> $location.path("/")

      #Define the REST resource to be used
      Recipe = $resource('/recipes/:recipeId',
        {recipeId: "@id", format: 'json'},
        {'save': {method: 'PUT'}, 'create': {method: 'POST'}})

      if $routeParams.recipeId
        Recipe.get({recipeId: $routeParams.recipeId},
          ( (recipe)-> $scope.recipe = recipe ),
          ( (httpResponse)->
            $scope.recipe = null
            flash.error   = "There is no recipe with ID #{$routeParams.recipeId}"
          )
        )
      else
        $scope.recipe = {}

      $scope.back   = -> $location.path("/") #Back button pressed
      $scope.edit   = -> $location.path("/recipes/#{$scope.recipe.id}/edit") # Edit button pressed

      #Method: Updates existing recipe or creates a new one
      $scope.save = ->
        onError = (_httpResponse)-> flash.error = "Something went wrong"

        if $scope.recipe.id #Existing recipe
          $scope.recipe.$save(
            ( ()-> $location.path("/recipes/#{$scope.recipe.id}") ),
            onError)
        else
          Recipe.create($scope.recipe,
            ( (newRecipe)-> $location.path("/recipes/#{newRecipe.id}") ),
            onError
          )

      $scope.delete = ->
        $scope.recipe.$delete()
        $scope.back()
  ])