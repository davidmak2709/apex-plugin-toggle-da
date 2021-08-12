FUNCTION render
(
 	p_dynamic_action apex_plugin.t_dynamic_action,
  	p_plugin         apex_plugin.t_plugin
)
RETURN apex_plugin.t_dynamic_action_render_result
AS
    l_result                 apex_plugin.t_dynamic_action_render_result;

    l_type			 p_dynamic_action.attribute_01%type := p_dynamic_action.attribute_01;
	l_animate        p_dynamic_action.attribute_02%type := p_dynamic_action.attribute_02;
    l_duration       p_dynamic_action.attribute_03%type := p_dynamic_action.attribute_03;

	v_type 		VARCHAR2(32);
	v_duration	INTEGER;
	b_animate 	BOOLEAN;
BEGIN
	b_animate 	:= CASE WHEN l_animate = 'Y' THEN TRUE ELSE FALSE END;
    v_duration	:= NVL(TO_NUMBER(l_duration), 0);

    -- debug info
    IF apex_application.g_debug THEN
        apex_plugin_util.debug_dynamic_action
		(
			p_plugin         => p_plugin,
          	p_dynamic_action => p_dynamic_action
      	);
    END IF;

    -- we add the files here since they are used across multiple plug-ins, so specifying a key will make sure only one file is added
    apex_javascript.add_library
  	(
		p_name           => apex_plugin_util.replace_substitutions('apexToggleDA#MIN#.js'),
  		p_directory      => p_plugin.file_prefix || 'js/',
  		p_skip_extension => true,
  		p_key            => 'ora-toggle-da'
  	);

    -- define our JSON config
    apex_json.initialize_clob_output;
    apex_json.open_object;

    -- plugin settings
    apex_json.write('animate', b_animate);

	IF b_animate THEN
		apex_json.write('type', NVL(l_type, 'basic'));

		IF v_duration < 1 THEN
			v_duration := 350;
		END IF;

		apex_json.write('duration', ABS(v_duration));

	END IF;

    apex_json.close_object;

    l_result.javascript_function := 'function(){apexToggleDA.basic.toggle(this, '||apex_json.get_clob_output||');}';

    apex_json.free_output;

    RETURN l_result;
	
END render;
