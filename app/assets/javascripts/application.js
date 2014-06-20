var k;

$(document).ready(function() {

    function Token() {
        var _this = this;

        _this.test = false;

        this.tok = function() {
            return _this.token;
        }

        this.ttl = function() {
            return _this.ttl;
        }

        this.hasToken = function() {

            if (_this.token.token !== null) {
                console.log("this has token: " + _this.token.token);
                return true;
            } else {
                console.log("this does not have token");
                return false;
            }
        }

        this.counter = function() {
            setInterval(function() {
                decrementTtl();
            }, 1000);
        }

        this.getJSON = function() {
            var jObj;
            if (_this.test !== true) {
                jObj = {
                    "user": {
                        "email": _this.email,
                        "password": _this.password
                    }
                }
                _this.test = true;
            } else {
                jObj = {
                    "api_session_token": {
                        "token": _this.token,
                        "ttl": _this.ttl,
                        "email": _this.email
                    }
                }
            }

            console.log(jObj);

            return jObj;
        }

        function decrementTtl() {
            _this.ttl = parseInt(_this.ttl);
            _this.ttl = _this.ttl - 1;
            if (_this.ttl <= 10) {
                renewToken();
            }
        }

        function setValues(params) {
            _this.token = params["api_session_token"]["token"];
            _this.ttl = params["api_session_token"]["ttl"];
            _this.ttl = parseInt(_this.ttl);

            if (!_this.test) {
                _this.password = null;
                _this.test = true;
            }

            $(function() {
                $.ajaxPrefilter(function(newOpts, oldOpts, xhr) {
                    xhr.setRequestHeader('Authorization', _this.token);
                });
            });
        }

        console.log("renewing token");

        this.renewToken = function() {
            $(function() {
                $.ajax({
                    dataType: "json",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
                    },
                    data: _this.getJSON(),
                    url: "http://localhost:3000/api/sessions",
                    type: "POST",
                    success: function(b) {
                        var items = {};
                        console.log(b);
                        setValues(b);
                    },
                    error: function(c, d, e) {
                        return b.set("error", "" + d + ": " + e)
                    }
                })
            });
        }
    }

    var k = new Token();

});