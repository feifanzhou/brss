# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
Profile = React.createClass
  getInitialState: ->
    return { user: {} }
  componentWillMount: ->
    _t = this
    $.ajax '/account', 
      type: 'GET'
      dataType: 'JSON'
      success: (data) ->
        _t.setState(user: data)
  render: ->
    React.DOM.nav
      id: 'profile'
      children: [
        React.DOM.img
          id: 'profilePicture'
        React.DOM.section
          id: 'profileInfo'
          children: [
            React.DOM.p
              id: 'displayName'
              children: @state.user.display_name
          ]
        React.DOM.ul
          id: 'contractsList'
      ]
React.renderComponent(Profile(), document.getElementById('container'))