var NationalID = {
    validator: null,

    validate: function(value) {
        if (this.Validators[this.validator.name]) {
            return this.Validators[this.validator.name].validate(value)
        } else {
            return this.Validators.None.validate(value)
        }
    },

    Validators: {
        None: {
            name: 'None',

            validate: function(value) {
                return true;
            }
        },

        Brazil: {
            name: 'Brazil',
            format: '###-###-###-##',

            validate: function(value) {
                var nid = value.replace(/[^0-9]/gmi, "");
                var id = nid.split("");

                // check that NID isn't just all zeros and is correct length
                if ((nid.replace(/[0]/gmi, "") == "") || (id.length != 11)) {
                    return false;
                }

                // check each NID digit is numeric
                for (var index = 0; index < id.length; index++) {
                    if (isNaN(parseInt(id[index]))) {
                        return false;
                    }
                    id[index] = parseInt(id[index]);
                }

                var v1 = 
                (
                  (
                    id[0] + (id[1] * 2) + (id[2] * 3) + (id[3] * 4) + (id[4] * 5) + 
                    (id[5] * 6) + (id[6] * 7) + (id[7] * 8) + (id[8] * 9)
                  ) % 11
                ) % 10;

                var v2 = 
                (
                  (
                    id[1] + (id[2] * 2) + (id[3] * 3) + (id[4] * 4) + (id[5] * 5) + 
                    (id[6] * 6) + (id[7] * 7) + (id[8] * 8) + (v1 * 9)
                  ) % 11
                ) % 10;

                if (v1 == id[9] && v2 == id[10]) {
                    return true;
                }

                return false;
            }
        },

        Norway: {
            name: 'Norway',
            format: '##-##-## #####',

            validate: function(value) {
                var nid = value.replace(/[^0-9]/gmi, "");
                var id = nid.split("");

                // check that NID isn't just all zeros and is correct length
                if ((nid.replace(/[0]/gmi, "") == "") || (id.length != 11)) {
                    return false;
                }

                // check each NID digit is numeric
                for (var index = 0; index < id.length; index++) {
                    if (isNaN(parseInt(id[index]))) {
                        return false;
                    }
                    id[index] = parseInt(id[index]);
                }

                first_value = 
                11 - (
                  (
                    (id[0] * 3) + (id[1] * 7) + (id[2] * 6) + (id[3] * 1) + 
                    (id[4] * 8) + (id[5] * 9) + (id[6] * 4) + (id[7] * 5) + 
                    (id[8] * 2)
                  ) % 11
                );

                second_value = 
                11 - (
                  (
                    (id[1] * 5) + (id[2] * 4) + (id[3] * 3) + (id[4] * 2) + 
                    (id[5] * 7) + (id[6] * 6) + (id[7] * 5) + (id[8] * 4) + 
                    (id[9] * 3) + (first_value * 2)
                  ) % 11
                );

                return (first_value == id[9] && second_value == id[10]);
            }
        }

        Poland: {
            name: 'Poland',
            format: '##-##-## #####',

            validate: function(value) {
                var nid = value.replace(/[^0-9]/gmi, "");
                var id = nid.split("");

                // check that NID isn't just all zeros and is correct length
                if ((nid.replace(/[0]/gmi, "") == "") || (id.length != 11)) {
                    return false;
                }

                // check each NID digit is numeric
                for (var index = 0; index < id.length; index++) {
                    if (isNaN(parseInt(id[index]))) {
                        return false;
                    }
                    id[index] = parseInt(id[index]);
                }

                var check_mod = 
                (
                    id[0] + (id[1] * 3) + (id[2] * 7) + (id[3] * 9) +
                    id[4] + (id[5] * 3) + (id[6] * 7) + (id[7] * 9) +
                    id[8] + (id[9] * 3)
                ) % 10;

                var check_value = 0;
                if (check_mod != 0) {
                    check_value = 10 - check_mod;
                }

                if (check_value == id[10]) {
                    return true;
                }

                return false;
            }
        },

        Turkey: {
            name: 'Turkey',
            format: '###-###-###-##',

            validate: function(value) {
                var nid = value.replace(/[^0-9]/gmi, "");
                var id = nid.split("");

                // check that NID isn't just all zeros and is correct length
                if ((nid.replace(/[0]/gmi, "") == "") || (id.length != 11) || (id[0] == '0')) {
                    return false;
                }

                // check each NID digit is numeric
                for (var index = 0; index < id.length; index++) {
                    if (isNaN(parseInt(id[index]))) {
                        return false;
                    }
                    id[index] = parseInt(id[index]);
                }

                first_value = 
                10 - (
                  (
                    3 * (id[0] + id[2] + id[4] + id[6] + id[8]) + id[1] + id[3] + id[5] + id[7]
                  ) % 10
                ) % 10;

                second_value = 
                (
                  10 - (
                    (id[0] + id[2] + id[4] + id[6] + id[8] + 3) * (id[1] + id[3] + id[5] + id[7] + first_value)
                  ) % 10
                ) % 10;

                return (first_value == id[9] && second_value == id[10]);
            }
        }
    }
}
