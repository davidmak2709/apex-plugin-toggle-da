/**
 * @namespace apexToggleDA
 **/
var apexToggleDA = apexToggleDA || {};

/**
 * @module basic
 **/
apexToggleDA.basic = {
    /**
     * @function toggle
     * @example apexToggleDA.basic.toggle();
     **/
    toggle: function(triggeringElement, props) {
        var duration = props.duration == null ? 350 : props.duration;

        if (props.type === 'fade') {
            $(triggeringElement.affectedElements).fadeToggle(duration);
        } else if (props.type === 'slide') {
            $(triggeringElement.affectedElements).slideToggle(duration);
        } else {
            $(triggeringElement.affectedElements).toggle();
        }

    }
};
