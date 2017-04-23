this.module('App', function() {
  return this.module('Cookies', function() {
    var scope = this;
    this.removeCode = -32;
    this.createCode = 32;

    setExpires = function(days){
      var date, expires;
      if (days) {
        date = new Date;
        date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
        expires = '; expires=' + date.toGMTString();
      } else {
        expires = '';
      }
      return expires;
    };

    this.createCookie = function(name, value, days, path) {
      path = path ? path : '/'; 
      return document.cookie = name + '=' + value + setExpires(days) + '; path=' + path;
    };

    this.createPathCookie = function(name, value, days) {
      return document.cookie = name + '=' + value + setExpires(days) + '; path=' + window.location.pathname;
    };

    this.list = function() {
      return _.object(_.map(document.cookie.split(" "), function(e) {return e.replace(/[;]+$/, '').split("=");}));
    };
    this.getCookie = function(c_name) {
      return scope.list()[c_name];
    };
  });
});

