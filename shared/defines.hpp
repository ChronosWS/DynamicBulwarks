// // Get parameter
// #define GET_PARAM(outVar, paramName, paramDefault)          outVar = [paramName,paramDefault] call shared_fnc_getSaveableParam;\
//                                                             publicVariable #outVar;\
//                                                             [format ["%1: %2", paramName, outVar], "PARAM"] call shared_fnc_log

// // Get parameter and convert to bool
// #define GET_PARAM_BOOL(outVar, paramName, paramDefault)     outVar = ([paramName,paramDefault] call shared_fnc_getSaveableParam) isEqualTo 1;\
//                                                             publicVariable #outVar;\
//                                                             [format ["%1: %2", paramName, outVar], "PARAM"] call shared_fnc_log

#define LOG_INFO "INFO"
#define LOG_ERR  "ERR"
#define LOG_WARN "WARN"

#define GET_PARAM_BY_INDEX(params, index) (params select index)
#define GET_PARAM_BY_ID(params, id) GET_PARAM_BY_INDEX(params, (params findIf { id == PARAM_GET_ID(_x) }))
#define GET_CURRENT_PARAM_BY_INDEX(index) (CurrentBulwarkParams select index)
#define GET_CURRENT_PARAM_BY_ID(id) GET_PARAM_BY_ID(CurrentBulwarkParams, id)

#define PARAM_CATEGORY_FILTERS "Filters"
#define PARAM_CATEGORY_WAVE "Waves"
#define PARAM_CATEGORY_START "Start Conditions"
#define PARAM_CATEGORY_BULWARK "Bulwark Configuration"
#define PARAM_CATEGORY_GAME "Game Configuration"
#define PARAM_CATEGORY_GEOGRAPHY "Geography"
#define PARAM_CATEGORY_UPGRADES "Upgrades"
#define PARAM_CATEGORY_PLAYER "Player Configuration"

// A boolean value (true/false)
#define PARAM_TYPE_BOOL 0

// A number value
#define PARAM_TYPE_NUMBER 1

// A string value
#define PARAM_TYPE_STRING 2

#define PARAM_INDEX_ID          0
#define PARAM_INDEX_TITLE       1
#define PARAM_INDEX_CATEGORY    2
#define PARAM_INDEX_TYPE        3
#define PARAM_INDEX_MULTISELECT 4
#define PARAM_INDEX_OPTIONS     5
#define PARAM_INDEX_VALUE       6
#define PARAM_INDEX_DESC        7

#define PARAM_INDEX_OPTION_NAME 0
#define PARAM_INDEX_OPTION_VALUE 1

// Param Getters
#define PARAM_GET_ID(param) (param select PARAM_INDEX_ID)
#define PARAM_GET_TITLE(param) (param select PARAM_INDEX_TITLE)
#define PARAM_GET_CATEGORY(param) (param select PARAM_INDEX_CATEGORY)
#define PARAM_GET_TYPE(param) (param select PARAM_INDEX_TYPE)
#define PARAM_IS_MULTISELECT(param) ((param select PARAM_INDEX_MULTISELECT) == 1)
#define PARAM_HAS_OPTIONS(param) (count (param select PARAM_INDEX_OPTIONS) > 0)
#define PARAM_GET_OPTIONS(param) (param select PARAM_INDEX_OPTIONS)
#define PARAM_GET_OPTION_BY_INDEX(param, index) (PARAM_GET_OPTIONS(param) select index)
#define PARAM_GET_VALUE(param) (param select PARAM_INDEX_VALUE)
#define PARAM_GET_DESC(param) (param select PARAM_INDEX_DESC)

#define PARAM_GET_OPTION_NAME(option) (option select PARAM_INDEX_OPTION_NAME)
#define PARAM_GET_OPTION_VALUE(option) (option select PARAM_INDEX_OPTION_VALUE)

// Param Setters
#define PARAM_SET_VALUE(param, value) param set [PARAM_INDEX_VALUE, value]

// Saved params
#define SAVED_PARAM_INDEX_ID    0
#define SAVED_PARAM_INDEX_VALUE 1

#define SAVED_PARAM_GET_ID(param) (param select SAVED_PARAM_INDEX_ID)
#define SAVED_PARAM_GET_VALUE(param) (param select SAVED_PARAM_INDEX_VALUE)

// Parameter Sets
#define PARAMSETS_DEFAULT_SET_NAME "Default"
#define PARAMSETS_SAVE_NAME "_ParameterSets"
#define PARAMSETS_SELECTED_SAVE_NAME "_SelectedParameterSet"

#define PARAMSET_TYPE_BUILTIN 0
#define PARAMSET_TYPE_CUSTOM 1

#define PARAMSET_INDEX_TITLE 0
#define PARAMSET_INDEX_TYPE 1

#define PARAMSET_GET_TITLE(set) (set select PARAMSET_INDEX_TITLE)
#define PARAMSET_GET_TYPE(set) (set select PARAMSET_INDEX_TYPE)
