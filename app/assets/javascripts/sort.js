<script>
(function () {
    var id_ = 'sortees';
    var boxes_ = document.querySelectorAll('#' + id_ + ' .box');
    var dragSrcEl_ = null;
    this.handleDragStart = function (e) {
        e.dataTransfer.effectAllowed = 'move';
        e.dataTransfer.setData('text/html', this.innerHTML);
        dragSrcEl_ = this;
        this.style.opacity = '0.5';
        // this/e.target is the source node.
        this.addClassName('moving');
    };
    this.handleDragOver = function (e) {
        if (e.preventDefault) {
            e.preventDefault(); // Allows us to drop.
        }
        e.dataTransfer.dropEffect = 'move';
        return false;
    };
    this.handleDragEnter = function (e) {
        this.addClassName('over');
    };
    this.handleDragLeave = function (e) {
        // this/e.target is previous target element.
        this.removeClassName('over');
    };
    this.handleDrop = function (e) {
        // this/e.target is current target element.

        if (e.stopPropagation) {
            e.stopPropagation(); // stops the browser from redirecting.
        }
        // Don't do anything if we're dropping on the same box we're dragging.
        if (dragSrcEl_ != this) {
            dragSrcEl_.innerHTML = this.innerHTML;
            this.innerHTML = e.dataTransfer.getData('text/html');
        }
        return false;
    };
    this.handleDragEnd = function (e) {
        // this/e.target is the source node.
        this.style.opacity = '1';

        [ ].forEach.call(boxes_, function (box) {
            box.removeClassName('over');
            box.removeClassName('moving');
        });
    };

    [ ].forEach.call(boxes_, function (box) {
        box.setAttribute('draggable', 'true');  // Enable boxes to be draggable.
        box.addEventListener('dragstart', this.handleDragStart, false);
        box.addEventListener('dragenter', this.handleDragEnter, false);
        box.addEventListener('dragover', this.handleDragOver, false);
        box.addEventListener('dragleave', this.handleDragLeave, false);
        box.addEventListener('drop', this.handleDrop, false);
        box.addEventListener('dragend', this.handleDragEnd, false);
    });
})();
</script>
