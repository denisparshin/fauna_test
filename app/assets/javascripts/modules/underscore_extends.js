(function(){
  _.chunk = function (array, size) {
    return array.reduce(function (res, item, index) {
      if (index % size === 0) { res.push([]); }
      res[res.length-1].push(item);
      return res;
    }, []);
  };

  _.getByKeys = function(obj, keys){
    keys = _.flatten([keys]);
    return _.object(_.compact(_.map(keys, function(key){
      return obj[key] ? [key, obj[key]] : null;
    })));
  };

}).call(this);
