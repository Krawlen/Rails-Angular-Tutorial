angular.module('services').factory('Recipe', ($resource) ->
  $resource('/recipes/:recipeId',
    {recipeId: "@id", format: 'json'},
    {'save': {method: 'PUT'}, 'create': {method: 'POST'}})
  )