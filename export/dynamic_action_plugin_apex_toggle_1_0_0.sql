prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>1177259860185678
,p_default_application_id=>128
,p_default_id_offset=>0
,p_default_owner=>'DMAKOVAC'
);
end;
/
 
prompt APPLICATION 128 - Toggle
--
-- Application Export:
--   Application:     128
--   Name:            Toggle
--   Date and Time:   12:08 Thursday August 12, 2021
--   Exported By:     DMAKOVAC
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 73364361563925564
--   Manifest End
--   Version:         20.2.0.00.20
--   Instance ID:     204264313969299
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/com_oraopensource_toggle
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(73364361563925564)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'COM.ORAOPENSOURCE.TOGGLE'
,p_display_name=>'APEX Plugin - Toggle'
,p_category=>'COMPONENT'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render',
'(',
' 	p_dynamic_action apex_plugin.t_dynamic_action,',
'  	p_plugin         apex_plugin.t_plugin',
')',
'RETURN apex_plugin.t_dynamic_action_render_result',
'AS',
'    l_result                 apex_plugin.t_dynamic_action_render_result;',
'',
'    l_type			 p_dynamic_action.attribute_01%type := p_dynamic_action.attribute_01;',
'	l_animate        p_dynamic_action.attribute_02%type := p_dynamic_action.attribute_02;',
'    l_duration       p_dynamic_action.attribute_03%type := p_dynamic_action.attribute_03;',
'',
'	v_type 		VARCHAR2(32);',
'	v_duration	INTEGER;',
'	b_animate 	BOOLEAN;',
'BEGIN',
'	b_animate 	:= CASE WHEN l_animate = ''Y'' THEN TRUE ELSE FALSE END;',
'    v_duration	:= NVL(TO_NUMBER(l_duration), 0);',
'	',
'    -- debug info',
'    IF apex_application.g_debug THEN',
'        apex_plugin_util.debug_dynamic_action',
'		( ',
'			p_plugin         => p_plugin,',
'          	p_dynamic_action => p_dynamic_action ',
'      	);',
'    END IF;',
'',
'    -- we add the files here since they are used across multiple plug-ins, so specifying a key will make sure only one file is added ',
'    apex_javascript.add_library ',
'  	( 	',
'		p_name           => apex_plugin_util.replace_substitutions(''apexToggleDA#MIN#.js''),',
'  		p_directory      => p_plugin.file_prefix || ''js/'',',
'  		p_skip_extension => true,',
'  		p_key            => ''ora-toggle-da''',
'  	);    ',
'',
'    -- define our JSON config',
'    apex_json.initialize_clob_output;',
'    apex_json.open_object;',
'    ',
'    -- plugin settings',
'    apex_json.write(''animate'', b_animate);',
'',
'	IF b_animate THEN',
'		apex_json.write(''type'', NVL(l_type, ''basic''));',
'	',
'		IF v_duration < 1 THEN',
'			v_duration := 350;',
'		END IF;',
'',
'		apex_json.write(''duration'', ABS(v_duration));		',
'',
'	END IF;',
'	',
'    apex_json.close_object;',
'    ',
'    l_result.javascript_function := ''function(){apexToggleDA.basic.toggle(this, ''||apex_json.get_clob_output||'');}'';',
'    ',
'    apex_json.free_output;',
'',
'    RETURN l_result;',
'END render;'))
,p_api_version=>2
,p_render_function=>'render'
,p_standard_attributes=>'ITEM:BUTTON:REGION:JQUERY_SELECTOR:REQUIRED'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_files_version=>12
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(73382051529365198)
,p_plugin_id=>wwv_flow_api.id(73364361563925564)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>21
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'basic'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(73384716532435002)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(73383419247385332)
,p_plugin_attribute_id=>wwv_flow_api.id(73382051529365198)
,p_display_sequence=>5
,p_display_value=>'Basic'
,p_return_value=>'basic'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(73382746958369115)
,p_plugin_attribute_id=>wwv_flow_api.id(73382051529365198)
,p_display_sequence=>10
,p_display_value=>'Slide'
,p_return_value=>'slide'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(73394652697816023)
,p_plugin_attribute_id=>wwv_flow_api.id(73382051529365198)
,p_display_sequence=>20
,p_display_value=>'Fade'
,p_return_value=>'fade'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(73384716532435002)
,p_plugin_id=>wwv_flow_api.id(73364361563925564)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>10
,p_prompt=>'Animate'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(73387504656476151)
,p_plugin_id=>wwv_flow_api.id(73364361563925564)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Duration (ms)'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(73382051529365198)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_EQUALS'
,p_depending_on_expression=>'basic'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2A0A202A20406E616D6573706163652061706578546F67676C6544410A202A2A2F0A7661722061706578546F67676C654441203D2061706578546F67676C654441207C7C207B7D3B0A0A2F2A2A0A202A20406D6F64756C652062617369630A202A2A';
wwv_flow_api.g_varchar2_table(2) := '2F0A61706578546F67676C6544412E6261736963203D207B0A202020202F2A2A0A20202020202A204066756E6374696F6E20746F67676C650A20202020202A20406578616D706C652061706578546F67676C6544412E62617369632E746F67676C652829';
wwv_flow_api.g_varchar2_table(3) := '3B0A20202020202A2A2F0A20202020746F67676C653A2066756E6374696F6E2874726967676572696E67456C656D656E742C2070726F707329207B0A2020202020202020766172206475726174696F6E203D2070726F70732E6475726174696F6E203D3D';
wwv_flow_api.g_varchar2_table(4) := '206E756C6C203F20333530203A2070726F70732E6475726174696F6E3B0A0A20202020202020206966202870726F70732E74797065203D3D3D2027666164652729207B0A202020202020202020202020242874726967676572696E67456C656D656E742E';
wwv_flow_api.g_varchar2_table(5) := '6166666563746564456C656D656E7473292E66616465546F67676C65286475726174696F6E293B0A20202020202020207D20656C7365206966202870726F70732E74797065203D3D3D2027736C6964652729207B0A202020202020202020202020242874';
wwv_flow_api.g_varchar2_table(6) := '726967676572696E67456C656D656E742E6166666563746564456C656D656E7473292E736C696465546F67676C65286475726174696F6E293B0A20202020202020207D20656C7365207B0A202020202020202020202020242874726967676572696E6745';
wwv_flow_api.g_varchar2_table(7) := '6C656D656E742E6166666563746564456C656D656E7473292E746F67676C6528293B0A20202020202020207D0A0A202020207D0A7D3B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(73395436436818475)
,p_plugin_id=>wwv_flow_api.id(73364361563925564)
,p_file_name=>'js/apexToggleDA.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7661722061706578546F67676C6544413D61706578546F67676C6544417C7C7B7D3B61706578546F67676C6544412E62617369633D7B746F67676C653A66756E6374696F6E2874726967676572696E67456C656D656E742C70726F7073297B7661722064';
wwv_flow_api.g_varchar2_table(2) := '75726174696F6E3D70726F70732E6475726174696F6E3D3D6E756C6C3F3335303A70726F70732E6475726174696F6E3B69662870726F70732E747970653D3D3D276661646527297B242874726967676572696E67456C656D656E742E6166666563746564';
wwv_flow_api.g_varchar2_table(3) := '456C656D656E7473292E66616465546F67676C65286475726174696F6E297D656C73652069662870726F70732E747970653D3D3D27736C69646527297B242874726967676572696E67456C656D656E742E6166666563746564456C656D656E7473292E73';
wwv_flow_api.g_varchar2_table(4) := '6C696465546F67676C65286475726174696F6E297D656C73657B242874726967676572696E67456C656D656E742E6166666563746564456C656D656E7473292E746F67676C6528297D7D7D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(73396028873829533)
,p_plugin_id=>wwv_flow_api.id(73364361563925564)
,p_file_name=>'js/apexToggleDA.min.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
