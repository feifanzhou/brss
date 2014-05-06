# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

AddNewProvision = React.createClass
  addProp: ->
    codeNode = @refs.provisionCode.getDOMNode()
    repNode = @refs.repName.getDOMNode()
    descNode = @refs.provisionDescription.getDOMNode()
    @props.addProvision(codeNode.value, repNode.value, descNode.value)
    codeNode.value = ''
    descNode.value = ''
  render: ->
    _t = this
    return React.DOM.section
      className: 'row'
      id: 'addNewProvision'
      children: [
        React.DOM.h1
          className: 'col-xs-12 col-md-2'
          id: 'addProvisionPrompt'
          children: 'Add new provision'
        React.DOM.div
          className: 'col-xs-12 col-md-10'
          children: 
            React.DOM.form
              className: 'row'
              id: 'addProvisionForm'
              children: [
                React.DOM.div
                  className: 'col-xs-12 col-md-4'
                  children: [
                    React.DOM.label
                      children: 'Provision code'
                    React.DOM.input
                      id: 'newProvisionCode'
                      type: 'text'
                      placeholder: 'BRSS2014'
                      ref: 'provisionCode'
                  ]
                React.DOM.div
                  className: 'col-xs-12 col-md-3'
                  children: [
                    React.DOM.label
                      children: 'Rep'
                    React.DOM.input
                      id: 'newRepName'
                      type: 'text'
                      placeholder: 'jblow'
                      ref: 'repName'
                  ]
                React.DOM.div
                  className: 'col-xs-12 col-md-4'
                  children: [
                    React.DOM.label
                      children: 'Description'
                    React.DOM.input
                      id: 'newProvisionDescription'
                      type: 'text'
                      placeholder: 'Other names'
                      ref: 'provisionDescription'
                  ]
                React.DOM.button
                  type: 'button'
                  className: 'btn btn-primary col-md-1'
                  children: 'Save'
                  onClick: _t.addProp
              ]
      ]
ProvisionsList = React.createClass
  render: ->
    _t = this
    c = @props.provisions.map (provision) ->
      React.DOM.div
        className: 'Provision row'
        children: [
          React.DOM.span
            className: 'Remove col-xs-1'
            children: React.DOM.button
              className: 'close'
              type: 'button'
              children: '\u00D7'
              onClick: ->
                _t.props.removeProvision(provision)
          React.DOM.span
            className: 'Code col-xs-2'
            children: provision.code
          React.DOM.span
            className: 'Name col-xs-2'
            children: provision.rep_name
          React.DOM.span
            className: 'Description col-xs-2'
            children: provision.description
          React.DOM.span
            className: 'CreatedAt col-xs-3'
            children: provision.created_at
          React.DOM.span
            className: 'Creator col-xs-2'
            children: provision.creator
        ]
    c.unshift(
      React.DOM.div
        className: 'ColumnLabels row'
        children: [
          React.DOM.span
            className: 'col-xs-1'
            children: ''
          React.DOM.span
            className: 'col-xs-2'
            children: 'Provision code'
          React.DOM.span
            className: 'col-xs-2'
            children: 'Rep name'
          React.DOM.span
            className: 'col-xs-2'
            children: 'Description'
          React.DOM.span
            className: 'col-xs-3'
            children: 'Creation time'
          React.DOM.span
            className: 'col-xs-2'
            children: 'Creator'
        ]
    )
    return React.DOM.div
      className: 'ProvisionsList row'
      children: c

ProvisionsRoot = React.createClass
  getInitialState: ->
    return { provisions: [] }
  componentWillMount: ->
    _t = this
    $.get ('/provisions.json'), (provisions) ->
      return if !provisions
      _t.setState(provisions: provisions)
  addProvision: (code, name, desc) ->
    _t = this
    provision = {
      code: code,
      description: desc,
      rep_name: name,
      is_deleted: false
    }
    $.post '/provisions',
      provision: provision
      (data) -> 
        # Replace with provision containing ID
        prov = data.provision
        newProvisions = _t.state.provisions
        # Will cause mismatch issues if another provision is added before the first one finishes round trip
        newProvisions.splice(-1, 1)
        newProvisions.push(prov)
        _t.setState(provisions: newProvisions)
    prov = {
      code: code,
      description: desc,
      rep_name: name
      creator: document.getElementById('name').innerHTML,
      created_at: (new Date()).toUTCString()
    }
    newProvisions = @state.provisions
    newProvisions.push(prov)
    @setState(provisions: newProvisions)
  removeProvision: (provision) ->
    $.ajax ('/provisions/' + provision.id),
      type: 'DELETE'
      dataType: 'JSON'
    newProvisions = @state.provisions.filter((prov) -> prov.id != provision.id)
    @setState(provisions: newProvisions)

  render: ->
    _t = this
    return React.DOM.div
      className: 'col-xs-12'
      id: 'provisionsBlock'
      children: [
        AddNewProvision(addProvision: _t.addProvision)
        ProvisionsList(provisions: @state.provisions, removeProvision: _t.removeProvision)
      ]
provisionTarget = document.getElementById('provisionTarget')
React.renderComponent(ProvisionsRoot(), provisionTarget) if provisionTarget != null

$('body').on('click', '#updateContracts', ->
  $('#wait').html('Refreshing&hellip;')
  $.ajax '/admin/refresh',
    type: 'POST',
    dataType: 'json',
    error: (jqXHR, textStatus, errorThrown) ->
      $('#wait').html('')
      alert('There was a problem refreshing contracts')
    success: (data, textStatus, jqXHR) ->
      $('#wait').html('')
      alert('Contracts refreshed')
)