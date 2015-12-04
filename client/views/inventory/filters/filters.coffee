Template.facetDropdown.helpers
  facetKeys: ->
    if Facets.findOne()
      _.keys(Facets.findOne().facets)
  value: ->
    key = @valueOf()
    active = Iron.query.get(key)?.split(',') || []
    _.map _.sortBy(Facets.findOne()?.facets[key], (f) -> -f.count), (l) ->
      _.extend l,
        key: key
        checked: if l.name in active then 'checked'

Template.facetCheckbox.events
  'change input:checkbox': (e, tpl) ->
    e.preventDefault()
    cur = Iron.query.get(@key)?.split(',') || []
    if $(e.target).is(':checked')
      cur.push @name
    else
      cur = _.without cur, @name

    Iron.query.set @key, _.uniq(cur).join()
