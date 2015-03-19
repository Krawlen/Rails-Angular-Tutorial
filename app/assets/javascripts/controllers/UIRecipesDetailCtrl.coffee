angular.module('controllers').controller("UIRecipesDetailCtrl",
  ['$scope', '$stateParams', '$resource', '$state', 'flash', 'Recipe',
    ($scope, $stateParams, $resource, $state, flash, Recipe)->

      # When displaying an existing recipe
      if $stateParams.recipeId
        Recipe.get({recipeId: $stateParams.recipeId},
          (recipe)-> $scope.recipe = recipe,
          ( (httpResponse)->
            $scope.recipe = null
            flash.error = "There is no recipe with ID #{$stateParams.recipeId}"
          )
        )
      else
      # When displaying a NEW recipe
        $scope.recipe = {}

      #Method: Updates existing recipe or creates a new one
      $scope.save = ->
        onError = (_httpResponse)-> flash.error = "Something went wrong"

        if $scope.recipe.id #Existing recipe
          $scope.recipe.$save(
            ()-> $state.go("recipes.detail", { recipeId: $scope.recipe.id}),
            onError)
        else #New recipe
          Recipe.create($scope.recipe,
            (newRecipe)-> $state.go("recipes.detail", { recipeId: newRecipe.id}),
            onError
          )
      $scope.delete = ->
        $scope.recipe.$delete()
        $state.go("recipes.list")
        console.log('redirect')
  ])