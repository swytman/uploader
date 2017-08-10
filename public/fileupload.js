(function ($) {
    var post_path = 'http://zel-football.ru:8111/files'; // url для сохранения

    var new_input_template =
        '<div class="input-group"> \
            <span class="input-group-btn">\
                <button class="btn btn-default btn-upload" type="button">\
                    <span class="glyphicon glyphicon-file"></span>\
                </button>\
            </span>\
            <input type="text" class="form-control input-path" readonly placeholder="Выберите файл">\
         </div>';

    function NewFileInput(file_input) {
        this.file_input = file_input;
        this.$file_input = $(file_input);
        this.swap();
    }

    NewFileInput.prototype.swap = function() {
        this.file_input.type='file';
        this.$file_input.hide();
        this.new_input = $(new_input_template);
        this.text_field = this.new_input.find('.input-path');
        var self = this;
        this.new_input.find('.btn-upload').click(function() {
            self.$file_input.trigger('click');
        });
        this.$file_input.change(function() {
            self.send(this.files[0]);
        });

        this.new_input.insertAfter(this.file_input);
    }

    NewFileInput.prototype.send = function(file) {
            var self = this;
            var xhr = new XMLHttpRequest();
            (xhr.upload || xhr).addEventListener('progress', function(e) {
                var done = e.position || e.loaded
                var total = e.totalSize || e.total;
                self.text_field.val(Math.round(done/total*100) + '%')
            });
            xhr.addEventListener('load', function(e) {
                var json_data = JSON.parse(this.responseText);
                self.text_field.val(json_data.path)
            });

            var fd = new FormData;
            fd.append('file', file);
            xhr.open('post', post_path, true);
            xhr.send(fd);
    };




    $(document).ready(function () {
        $("input[data-file-upload=true]").each(function() {
            new NewFileInput(this);
        });
    });

})(window.jQuery);