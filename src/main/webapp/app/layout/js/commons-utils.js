$(function () {
    function select3OptionFormat(option) {
        var originalOption = option.element;
        if ($(originalOption).data('html')) {
            return $(originalOption).data('html');
        }
        return option.text;
    }


    $('.select2').select2();
    $('.select3').select2({
        formatResult: select3OptionFormat,
        formatSelection: select3OptionFormat,
        escapeMarkup: function (m) {
            return m;
        }
    });
    $('.selectMultiple').select2({
        tags: true,
        tokenSeparators: [','],
        placeholder: "Selecione ou digite algo"
    });
});
