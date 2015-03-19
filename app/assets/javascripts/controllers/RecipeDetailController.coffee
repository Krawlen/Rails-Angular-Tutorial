controllers = angular.module('controllers')
controllers.controller("RecipeDetailController",
  ['$scope', '$stateParams', '$resource', '$location', 'flash',
    ($scope, $stateParams, $resource, $location, flash)->
      #Define the REST resource to be used
      Recipe = $resource('/recipes/:recipeId',
        {recipeId: "@id", format: 'json'},
        {'save': {method: 'PUT'}, 'create': {method: 'POST'}})

      if $stateParams.recipeId
        Recipe.get({recipeId: $stateParams.recipeId},
          ( (recipe)-> $scope.recipe = recipe ),
          ( (httpResponse)->
            $scope.recipe = null
            flash.error   = "There is no recipe with ID #{$stateParams.recipeId}"
          )
        )
      else
        $scope.recipe = {}

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

  ])