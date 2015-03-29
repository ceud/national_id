var NationalID = {
    validator: null,

    valid: function(value) {
        if (this.Validators[this.validator.name]) {
            return this.Validators[this.validator.name].valid(value);
        } else {
            return this.Validators.Base.valid(value);
        }
    },

    Validators: {
        Base: {
            name: 'Base',

            valid: function(value) {
                return true;
            }
        },

        Brazil: {
            name: 'Brazil',
            format: '###-###-###-##',

            valid: function(value) {
                if (!NationalID.not_zeroes(value) || 
                    !NationalID.correct_length(value, NationalID.format()) || 
                    !NationalID.all_numeric(value)) {
                    return false;
                }

                var id = NationalID.id_list(value);

                var first_value = 
                (
                  (
                    id[0] + (id[1] * 2) + (id[2] * 3) + (id[3] * 4) + (id[4] * 5) + 
                    (id[5] * 6) + (id[6] * 7) + (id[7] * 8) + (id[8] * 9)
                  ) % 11
                ) % 10;

                var second_value = 
                (
                  (
                    id[1] + (id[2] * 2) + (id[3] * 3) + (id[4] * 4) + (id[5] * 5) + 
                    (id[6] * 6) + (id[7] * 7) + (id[8] * 8) + (first_value * 9)
                  ) % 11
                ) % 10;

                return (first_value == id[9] && second_value == id[10]);
            }
        },

        Norway: {
            name: 'Norway',
            format: '##-##-## #####',

            valid: function(value) {
                if (!NationalID.not_zeroes(value) || 
                    !NationalID.correct_length(value, NationalID.format()) || 
                    !NationalID.all_numeric(value)) {
                    return false;
                }

                var id = NationalID.id_list(value);

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
        },

        Poland: {
            name: 'Poland',
            format: '##-##-## #####',

            valid: function(value) {
                if (!NationalID.not_zeroes(value) || 
                    !NationalID.correct_length(value, NationalID.format()) || 
                    !NationalID.all_numeric(value)) {
                    return false;
                }

                var id = NationalID.id_list(value);

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

                return (check_value == id[10]);
            }
        },

        Turkey: {
            name: 'Turkey',
            format: '###-###-###-##',

            valid: function(value) {
                if (!NationalID.not_zeroes(value) || 
                    !NationalID.correct_length(value, NationalID.format()) || 
                    !NationalID.not_start_with_zero(value) || 
                    !NationalID.all_numeric(value)) {
                    return false;
                }

                var id = NationalID.id_list(value);

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
    },

    format: function() {
        if (this.Validators[this.validator.name]) {
            return this.Validators[this.validator.name].format;
        } else {
            return '';
        }
    },

    not_zeroes: function(value) {
        return ((value.replace(/[0]/gmi, "") != "") ? true : false);
    },

    not_start_with_zero: function(value) {
        return ((value[0] != '0') ? true : false);
    },

    correct_length: function(value, format) {
        return ((value.length == format.length) ? true : false);
    },

    all_numeric: function(value) {
        var id_list = NationalID.string_id_list(value);
        for (var index = 0; index < id_list.length; index++) {
            if (isNaN(parseInt(id_list[index]))) {
                return false;
            }
        }
        return true;
    },

    id_list: function(value) {
        return NationalID.string_id_list(value).map(Number);
    },

    string_id_list: function(value) {
        return value.replace(/[^0-9]/gmi, '').split('');
    }
}
