define []
        , () ->
  class TestService
    constructor: ->
      @vals = [ 'bar1', 'lazy-bar', 'handlebar', 'typo bar', 'barbarbierbarbierbarbar']
      console.log 'TestService constructor called'
      
      e = new Error('dummy');
      stack = e.stack.replace(/^[^\(]+?[\n$]/gm, '')
        .replace(/^\s+at\s+/gm, '')
        .replace(/^Object.<anonymous>\s*\(/gm, '{anonymous}()@')
        .split('\n');
      console.dir(stack);
      
      
      setTimeout =>
        @vals.push ':D:D:D'
      , 10 * 1000
    
    foo: ->
      console.log 'foo'
      
    get: ->
      return @vals
  
  console.log 'defined TestService'
  TestService