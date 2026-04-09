#define CAML_NAME_SPACE
#include <caml/alloc.h>
#include <caml/callback.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <limits.h>
#include <oniguruma.h>

#define Regex_val(v) (*((regex_t**)Data_custom_val(v)))
#define Region_val(v) (*((OnigRegion**)Data_custom_val(v)))

typedef struct {
    OnigRegSet* regset;
    value regexes;
} regset_t;

#define RegSet_val(v) ((regset_t*)Data_custom_val(v))

#define WRAP(name, wrapped)                                                    \
    CAMLprim value name(value unit)                                            \
    {                                                                          \
        CAMLparam1(unit);                                                      \
        CAMLlocal1(v);                                                         \
        v = caml_alloc_small(1, Abstract_tag);                                 \
        Field(v, 0) = (value)wrapped;                                          \
        CAMLreturn(v);                                                         \
    }

static const value* ocaml_onig_Error_exn = NULL;
static const value* ocaml_Invalid_argument_exn = NULL;
static const value* ocaml_Failure_exn = NULL;

static regex_t* get_regex(value regex_val)
{
    regex_t* const regex = Regex_val(regex_val);
    if (regex == NULL) {
        caml_raise_with_string(
            *ocaml_Failure_exn,
            "This regex is owned by a RegSet and is no longer available");
    }
    return regex;
}

CAMLprim value ocaml_onig_initialize(value unit)
{
    CAMLparam1(unit);
    ocaml_onig_Error_exn = caml_named_value("Oniguruma.Error");
    ocaml_Invalid_argument_exn = caml_named_value("Oniguruma.Invalid_argument");
    ocaml_Failure_exn = caml_named_value("Oniguruma.Failure");
    OnigEncoding use_encodings[] = {
        ONIG_ENCODING_ASCII,       ONIG_ENCODING_ISO_8859_1,
        ONIG_ENCODING_ISO_8859_2,  ONIG_ENCODING_ISO_8859_3,
        ONIG_ENCODING_ISO_8859_4,  ONIG_ENCODING_ISO_8859_5,
        ONIG_ENCODING_ISO_8859_6,  ONIG_ENCODING_ISO_8859_7,
        ONIG_ENCODING_ISO_8859_8,  ONIG_ENCODING_ISO_8859_9,
        ONIG_ENCODING_ISO_8859_10, ONIG_ENCODING_ISO_8859_11,
        ONIG_ENCODING_ISO_8859_13, ONIG_ENCODING_ISO_8859_14,
        ONIG_ENCODING_ISO_8859_15, ONIG_ENCODING_ISO_8859_16,
        ONIG_ENCODING_UTF8,        ONIG_ENCODING_UTF16_BE,
        ONIG_ENCODING_UTF16_LE,    ONIG_ENCODING_UTF32_BE,
        ONIG_ENCODING_UTF32_LE,    ONIG_ENCODING_EUC_JP,
        ONIG_ENCODING_EUC_TW,      ONIG_ENCODING_EUC_KR,
        ONIG_ENCODING_EUC_CN,      ONIG_ENCODING_SJIS,
        ONIG_ENCODING_KOI8_R,      ONIG_ENCODING_CP1251,
        ONIG_ENCODING_BIG5,        ONIG_ENCODING_GB18030};
    onig_initialize(
        use_encodings, sizeof(use_encodings) / sizeof(use_encodings[0]));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_end(value unit)
{
    CAMLparam1(unit);
    onig_end();
    CAMLreturn(unit);
}

WRAP(ocaml_get_onig_encoding_ascii, ONIG_ENCODING_ASCII)
WRAP(ocaml_get_onig_encoding_iso_8859_1, ONIG_ENCODING_ISO_8859_1)
WRAP(ocaml_get_onig_encoding_iso_8859_2, ONIG_ENCODING_ISO_8859_2)
WRAP(ocaml_get_onig_encoding_iso_8859_3, ONIG_ENCODING_ISO_8859_3)
WRAP(ocaml_get_onig_encoding_iso_8859_4, ONIG_ENCODING_ISO_8859_4)
WRAP(ocaml_get_onig_encoding_iso_8859_5, ONIG_ENCODING_ISO_8859_5)
WRAP(ocaml_get_onig_encoding_iso_8859_6, ONIG_ENCODING_ISO_8859_6)
WRAP(ocaml_get_onig_encoding_iso_8859_7, ONIG_ENCODING_ISO_8859_7)
WRAP(ocaml_get_onig_encoding_iso_8859_8, ONIG_ENCODING_ISO_8859_8)
WRAP(ocaml_get_onig_encoding_iso_8859_9, ONIG_ENCODING_ISO_8859_9)
WRAP(ocaml_get_onig_encoding_iso_8859_10, ONIG_ENCODING_ISO_8859_10)
WRAP(ocaml_get_onig_encoding_iso_8859_11, ONIG_ENCODING_ISO_8859_11)
WRAP(ocaml_get_onig_encoding_iso_8859_13, ONIG_ENCODING_ISO_8859_13)
WRAP(ocaml_get_onig_encoding_iso_8859_14, ONIG_ENCODING_ISO_8859_14)
WRAP(ocaml_get_onig_encoding_iso_8859_15, ONIG_ENCODING_ISO_8859_15)
WRAP(ocaml_get_onig_encoding_iso_8859_16, ONIG_ENCODING_ISO_8859_16)
WRAP(ocaml_get_onig_encoding_utf8, ONIG_ENCODING_UTF8)
WRAP(ocaml_get_onig_encoding_utf16_be, ONIG_ENCODING_UTF16_BE)
WRAP(ocaml_get_onig_encoding_utf16_le, ONIG_ENCODING_UTF16_LE)
WRAP(ocaml_get_onig_encoding_utf32_be, ONIG_ENCODING_UTF32_BE)
WRAP(ocaml_get_onig_encoding_utf32_le, ONIG_ENCODING_UTF32_LE)
WRAP(ocaml_get_onig_encoding_euc_jp, ONIG_ENCODING_EUC_JP)
WRAP(ocaml_get_onig_encoding_euc_tw, ONIG_ENCODING_EUC_TW)
WRAP(ocaml_get_onig_encoding_euc_kr, ONIG_ENCODING_EUC_KR)
WRAP(ocaml_get_onig_encoding_euc_cn, ONIG_ENCODING_EUC_CN)
WRAP(ocaml_get_onig_encoding_sjis, ONIG_ENCODING_SJIS)
WRAP(ocaml_get_onig_encoding_koi8_r, ONIG_ENCODING_KOI8_R)
WRAP(ocaml_get_onig_encoding_cp1251, ONIG_ENCODING_CP1251)
WRAP(ocaml_get_onig_encoding_big5, ONIG_ENCODING_BIG5)
WRAP(ocaml_get_onig_encoding_gb18030, ONIG_ENCODING_GB18030)

WRAP(ocaml_get_onig_syntax_asis, ONIG_SYNTAX_ASIS)
WRAP(ocaml_get_onig_syntax_posix_basic, ONIG_SYNTAX_POSIX_BASIC)
WRAP(ocaml_get_onig_syntax_posix_extended, ONIG_SYNTAX_POSIX_EXTENDED)
WRAP(ocaml_get_onig_syntax_emacs, ONIG_SYNTAX_EMACS)
WRAP(ocaml_get_onig_syntax_grep, ONIG_SYNTAX_GREP)
WRAP(ocaml_get_onig_syntax_gnu_regex, ONIG_SYNTAX_GNU_REGEX)
WRAP(ocaml_get_onig_syntax_java, ONIG_SYNTAX_JAVA)
WRAP(ocaml_get_onig_syntax_perl, ONIG_SYNTAX_PERL)
WRAP(ocaml_get_onig_syntax_perl_ng, ONIG_SYNTAX_PERL_NG)
WRAP(ocaml_get_onig_syntax_default, ONIG_SYNTAX_DEFAULT)

static void finalize_regex_t(value v)
{
    regex_t* const regex = Regex_val(v);
    if (regex != NULL) {
        onig_free(regex);
        Regex_val(v) = NULL;
    }
}

static struct custom_operations regex_ops = {
    .identifier = "oniguruma.t",
    .finalize = finalize_regex_t,
    .compare = custom_compare_default,
    .compare_ext = custom_compare_ext_default,
    .hash = custom_hash_default,
    .serialize = custom_serialize_default,
    .deserialize = custom_deserialize_default,
    .fixed_length = custom_fixed_length_default,
};

OnigOptionType option(int v)
{
    switch (v) {
    case 0:
        return ONIG_OPTION_NONE;
    case 1:
        return ONIG_OPTION_SINGLELINE;
    case 2:
        return ONIG_OPTION_MULTILINE;
    case 3:
        return ONIG_OPTION_IGNORECASE;
    case 4:
        return ONIG_OPTION_EXTEND;
    case 5:
        return ONIG_OPTION_FIND_LONGEST;
    case 6:
        return ONIG_OPTION_FIND_NOT_EMPTY;
    case 7:
        return ONIG_OPTION_NEGATE_SINGLELINE;
    case 8:
        return ONIG_OPTION_DONT_CAPTURE_GROUP;
    case 9:
        return ONIG_OPTION_CAPTURE_GROUP;
    case 10:
        return ONIG_OPTION_NOTBOL;
    case 11:
        return ONIG_OPTION_NOTEOL;
    case 12:
        return ONIG_OPTION_NOT_BEGIN_POSITION;
    case 13:
        return ONIG_OPTION_IGNORECASE_IS_ASCII;
    case 14:
        return ONIG_OPTION_WORD_IS_ASCII;
    case 15:
        return ONIG_OPTION_DIGIT_IS_ASCII;
    case 16:
        return ONIG_OPTION_SPACE_IS_ASCII;
    case 17:
        return ONIG_OPTION_POSIX_IS_ASCII;
    case 18:
        return ONIG_OPTION_TEXT_SEGMENT_EXTENDED_GRAPHEME_CLUSTER;
    case 19:
        return ONIG_OPTION_TEXT_SEGMENT_WORD;
    case 20:
        return ONIG_OPTION_NOT_BEGIN_STRING;
    case 21:
        return ONIG_OPTION_NOT_END_STRING;
    case 22:
        return ONIG_OPTION_POSIX_REGION;
    case 23:
        return ONIG_OPTION_CHECK_VALIDITY_OF_STRING;
    case 24:
        return ONIG_OPTION_CALLBACK_EACH_MATCH;
    }
    caml_raise_with_string(*ocaml_Failure_exn, "option: Unreachable");
}

CAMLprim value ocaml_onig_option(value int_val)
{
    CAMLparam1(int_val);
    CAMLreturn(Val_int(option(Int_val(int_val))));
}

CAMLprim value
ocaml_onig_new(value pattern_val, value options, value enc, value syntax)
{
    CAMLparam4(pattern_val, options, enc, syntax);
    CAMLlocal3(regex_val, error, result);

    regex_t* regex;
    const UChar* const pattern = (const UChar*)String_val(pattern_val);
    const uintnat pattern_length = caml_string_length(pattern_val);

    OnigErrorInfo err_info;
    const int err_code = onig_new(
        &regex,
        pattern,
        pattern + pattern_length,
        Int_val(options),
        *((OnigEncoding*)Data_abstract_val(enc)),
        *((OnigSyntaxType**)Data_abstract_val(syntax)),
        &err_info);
    if (err_code != ONIG_NORMAL) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, err_code, &err_info);
        error = caml_copy_string((const char*)err_buf);
        /* Must store all fields immediately after small allocation! */
        result = caml_alloc_small(1, 1);
        Field(result, 0) = error;
        CAMLreturn(result);
    }
    regex_val = caml_alloc_custom(&regex_ops, sizeof(regex_t*), 0, 1);
    Regex_val(regex_val) = regex;
    /* Must store all fields immediately after small allocation! */
    result = caml_alloc_small(1, 0);
    Field(result, 0) = regex_val;
    CAMLreturn(result);
}

static void finalize_region(value v) { onig_region_free(Region_val(v), 1); }

static struct custom_operations region_ops = {
    .identifier = "oniguruma.region.t",
    .finalize = finalize_region,
    .compare = custom_compare_default,
    .compare_ext = custom_compare_ext_default,
    .hash = custom_hash_default,
    .serialize = custom_serialize_default,
    .deserialize = custom_deserialize_default,
    .fixed_length = custom_fixed_length_default,
};

static void finalize_regset(value v)
{
    regset_t* const regset = RegSet_val(v);
    if (regset->regexes != Val_unit) {
        const mlsize_t regex_count = Wosize_val(regset->regexes);
        for (mlsize_t i = 0; i < regex_count; ++i) {
            Regex_val(Field(regset->regexes, i)) = NULL;
        }
    }
    if (regset->regset != NULL) {
        onig_regset_free(regset->regset);
        regset->regset = NULL;
    }
    if (regset->regexes != Val_unit) {
        caml_remove_generational_global_root(&regset->regexes);
        regset->regexes = Val_unit;
    }
}

static struct custom_operations regset_ops = {
    .identifier = "oniguruma.regset.t",
    .finalize = finalize_regset,
    .compare = custom_compare_default,
    .compare_ext = custom_compare_ext_default,
    .hash = custom_hash_default,
    .serialize = custom_serialize_default,
    .deserialize = custom_deserialize_default,
    .fixed_length = custom_fixed_length_default,
};

CAMLprim value ocaml_onig_regset_new(value regexes_val)
{
    CAMLparam1(regexes_val);
    CAMLlocal1(regset_val);

    const mlsize_t regex_count = Wosize_val(regexes_val);
    if (regex_count > INT_MAX) {
        caml_raise_with_string(
            *ocaml_Invalid_argument_exn,
            "regset_new: Too many regexes in array");
    }

    OnigRegex* regs = NULL;
    if (regex_count > 0) {
        regs = caml_stat_alloc(sizeof(OnigRegex) * regex_count);
        for (mlsize_t i = 0; i < regex_count; ++i) {
            regs[i] = get_regex(Field(regexes_val, i));
        }
    }

    OnigRegSet* regset = NULL;
    const int result = onig_regset_new(&regset, (int)regex_count, regs);
    if (regs != NULL) {
        caml_stat_free(regs);
    }

    if (result != ONIG_NORMAL) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }

    regset_val = caml_alloc_custom(&regset_ops, sizeof(regset_t), 0, 1);
    regset_t* const wrapped = RegSet_val(regset_val);
    wrapped->regset = regset;
    wrapped->regexes = regexes_val;
    caml_register_generational_global_root(&wrapped->regexes);

    CAMLreturn(regset_val);
}

CAMLprim value ocaml_onig_regset_search(
    value regset_val,
    value string_val,
    value search_start_val,
    value search_end_val,
    value options_val)
{
    CAMLparam5(
        regset_val, string_val, search_start_val, search_end_val, options_val);
    CAMLlocal3(region_val, tuple_val, option_val);

    const regset_t* const wrapped = RegSet_val(regset_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    const int search_start = Int_val(search_start_val);
    const int search_end = Int_val(search_end_val);
    int match_position = -1;

    const int result = onig_regset_search(
        wrapped->regset,
        string,
        string + string_length,
        string + search_start,
        string + search_end,
        ONIG_REGSET_POSITION_LEAD,
        Long_val(options_val),
        &match_position);
    (void)match_position;

    if (result == ONIG_MISMATCH) {
        CAMLreturn(Val_int(0));
    }
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    const int matched_regex_index = result;
    if (matched_regex_index < 0) {
        caml_raise_with_string(
            *ocaml_Failure_exn, "regset_search: Invalid matched regex index");
    }

    OnigRegion* const region =
        onig_regset_get_region(wrapped->regset, matched_regex_index);
    if (region == NULL) {
        caml_raise_with_string(
            *ocaml_Failure_exn, "regset_search: Missing region for matched regex");
    }

    OnigRegion* const copied_region = onig_region_new();
    if (copied_region == NULL) {
        caml_raise_out_of_memory();
    }
    onig_region_copy(copied_region, region);

    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = copied_region;

    tuple_val = caml_alloc_tuple(2);
    Store_field(tuple_val, 0, Val_int(matched_regex_index));
    Store_field(tuple_val, 1, region_val);

    option_val = caml_alloc_small(1, 0);
    Field(option_val, 0) = tuple_val;
    CAMLreturn(option_val);
}

CAMLprim value ocaml_onig_search(
    value regex_val,
    value string_val,
    value search_start_val,
    value search_end_val,
    value options_val)
{
    CAMLparam5(
        regex_val, string_val, search_start_val, search_end_val, options_val);
    CAMLlocal2(region_val, option_val);

    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    const int search_start = Int_val(search_start_val);
    const int search_end = Int_val(search_end_val);

    OnigRegion* const region = onig_region_new();
    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = region;
    /* Oniguruma library should handle out-of-bounds ranges */
    const int result = onig_search(
        regex,
        string,
        string + string_length,
        string + search_start,
        string + search_end,
        region,
        Long_val(options_val));
    if (result == ONIG_MISMATCH) {
        CAMLreturn(Val_int(0));
    }
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    /* option_val : region option */
    /* Must store all fields immediately after small allocation! */
    option_val = caml_alloc_small(1, 0);
    Field(option_val, 0) = region_val;
    CAMLreturn(option_val);
}

CAMLprim value ocaml_onig_match(
    value regex_val,
    value string_val,
    value search_at_val,
    value options_val)
{
    CAMLparam4(regex_val, string_val, search_at_val, options_val);
    CAMLlocal2(region_val, option_val);

    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    const int search_at = Int_val(search_at_val);

    OnigRegion* const region = onig_region_new();
    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = region;
    /* Oniguruma library should handle out-of-bounds ranges */
    const int result = onig_match(
        regex,
        string,
        string + string_length,
        string + search_at,
        region,
        Long_val(options_val));
    if (result == ONIG_MISMATCH) {
        CAMLreturn(Val_int(0));
    }
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    /* option_val : region option */
    /* Must store all fields immediately after small allocation! */
    option_val = caml_alloc_small(1, 0);
    Field(option_val, 0) = region_val;
    CAMLreturn(option_val);
}

CAMLprim value ocaml_onig_region_length(value region)
{
    CAMLparam1(region);
    CAMLreturn(Val_int(Region_val(region)->num_regs));
}

CAMLprim value ocaml_onig_capture_beg(value region_val, value idx_val)
{
    CAMLparam2(region_val, idx_val);
    const OnigRegion* const region = Region_val(region_val);
    const long int idx = Long_val(idx_val);
    if (idx >= 0 && idx < region->num_regs) {
        CAMLreturn(Val_int(region->beg[idx]));
    }
    caml_raise_with_string(
        *ocaml_Invalid_argument_exn, "capture_beg: Index out of bounds");
}

CAMLprim value ocaml_onig_capture_end(value region_val, value idx_val)
{
    CAMLparam2(region_val, idx_val);
    const OnigRegion* const region = Region_val(region_val);
    const long int idx = Long_val(idx_val);
    if (idx >= 0 && idx < region->num_regs) {
        CAMLreturn(Val_int(region->end[idx]));
    }
    caml_raise_with_string(
        *ocaml_Invalid_argument_exn, "capture_end: Index out of bounds");
}

CAMLprim value ocaml_onig_num_captures(value regex)
{
    CAMLparam1(regex);
    CAMLreturn(Val_int(onig_number_of_captures(get_regex(regex))));
}

CAMLprim value
ocaml_onig_name_to_group_numbers(value regex_val, value string_val)
{
    CAMLparam2(regex_val, string_val);
    CAMLlocal1(arr_val);
    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    int* num_list;
    int length = onig_name_to_group_numbers(
        regex, string, string + string_length, &num_list);
    /* As far as I can tell, the documentation's claim that the function
       returns -1 if the name is not found is incorrect. */
    if (length < 0) {
        length = 0;
    }
    arr_val = caml_alloc(length, 0);
    for (int i = 0; i < length; ++i) {
        Store_field(arr_val, i, Val_int(num_list[i]));
    }
    CAMLreturn(arr_val);
}

CAMLprim value ocaml_onig_version(value unit)
{
    CAMLparam1(unit);
    CAMLlocal1(str);
    str = caml_copy_string(onig_version());
    CAMLreturn(str);
}

#define MatchParam_val(v) (*((OnigMatchParam**)Data_custom_val(v)))

static void finalize_match_param(value v)
{
    OnigMatchParam* const mp = MatchParam_val(v);
    if (mp != NULL) {
        onig_free_match_param(mp);
        MatchParam_val(v) = NULL;
    }
}

static struct custom_operations match_param_ops = {
    .identifier = "oniguruma.match_param.t",
    .finalize = finalize_match_param,
    .compare = custom_compare_default,
    .compare_ext = custom_compare_ext_default,
    .hash = custom_hash_default,
    .serialize = custom_serialize_default,
    .deserialize = custom_deserialize_default,
    .fixed_length = custom_fixed_length_default,
};

CAMLprim value ocaml_onig_new_match_param(value unit)
{
    CAMLparam1(unit);
    CAMLlocal1(mp_val);
    OnigMatchParam* const mp = onig_new_match_param();
    if (mp == NULL) {
        caml_raise_out_of_memory();
    }
    onig_initialize_match_param(mp);
    mp_val =
        caml_alloc_custom(&match_param_ops, sizeof(OnigMatchParam*), 0, 1);
    MatchParam_val(mp_val) = mp;
    CAMLreturn(mp_val);
}

CAMLprim value
ocaml_onig_match_param_set_match_stack_limit(value mp_val, value limit_val)
{
    CAMLparam2(mp_val, limit_val);
    onig_set_match_stack_limit_size_of_match_param(
        MatchParam_val(mp_val), (unsigned int)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value
ocaml_onig_match_param_set_retry_limit_in_match(value mp_val, value limit_val)
{
    CAMLparam2(mp_val, limit_val);
    onig_set_retry_limit_in_match_of_match_param(
        MatchParam_val(mp_val), (unsigned long)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value
ocaml_onig_match_param_set_retry_limit_in_search(value mp_val, value limit_val)
{
    CAMLparam2(mp_val, limit_val);
    onig_set_retry_limit_in_search_of_match_param(
        MatchParam_val(mp_val), (unsigned long)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_search_with_param(
    value regex_val,
    value string_val,
    value search_start_val,
    value search_end_val,
    value options_val,
    value mp_val)
{
    CAMLparam5(regex_val, string_val, search_start_val, search_end_val,
               options_val);
    CAMLxparam1(mp_val);
    CAMLlocal2(region_val, option_val);

    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    const int search_start = Int_val(search_start_val);
    const int search_end = Int_val(search_end_val);

    OnigRegion* const region = onig_region_new();
    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = region;
    const int result = onig_search_with_param(
        regex,
        string,
        string + string_length,
        string + search_start,
        string + search_end,
        region,
        Long_val(options_val),
        MatchParam_val(mp_val));
    if (result == ONIG_MISMATCH) {
        CAMLreturn(Val_int(0));
    }
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    option_val = caml_alloc_small(1, 0);
    Field(option_val, 0) = region_val;
    CAMLreturn(option_val);
}

CAMLprim value ocaml_onig_search_with_param_bc(value* argv, int argn)
{
    (void)argn;
    return ocaml_onig_search_with_param(
        argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

CAMLprim value ocaml_onig_match_with_param(
    value regex_val,
    value string_val,
    value search_at_val,
    value options_val,
    value mp_val)
{
    CAMLparam5(regex_val, string_val, search_at_val, options_val, mp_val);
    CAMLlocal2(region_val, option_val);

    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);
    const int search_at = Int_val(search_at_val);

    OnigRegion* const region = onig_region_new();
    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = region;
    const int result = onig_match_with_param(
        regex,
        string,
        string + string_length,
        string + search_at,
        region,
        Long_val(options_val),
        MatchParam_val(mp_val));
    if (result == ONIG_MISMATCH) {
        CAMLreturn(Val_int(0));
    }
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    option_val = caml_alloc_small(1, 0);
    Field(option_val, 0) = region_val;
    CAMLreturn(option_val);
}

static int scan_callback_trampoline(
    int count,
    int pos,
    OnigRegion* region,
    void* arg)
{
    CAMLparam0();
    CAMLlocal2(region_val, result_val);

    value callback = *(value*)arg;

    OnigRegion* const copied = onig_region_new();
    if (copied == NULL) {
        caml_raise_out_of_memory();
    }
    onig_region_copy(copied, region);
    region_val = caml_alloc_custom(&region_ops, sizeof(OnigRegion*), 0, 1);
    Region_val(region_val) = copied;

    result_val = caml_callback3(callback, Val_int(count), Val_int(pos),
                                region_val);
    CAMLreturnT(int, Bool_val(result_val) ? 0 : 1);
}

CAMLprim value ocaml_onig_scan(
    value regex_val,
    value string_val,
    value options_val,
    value callback_val)
{
    CAMLparam4(regex_val, string_val, options_val, callback_val);

    regex_t* const regex = get_regex(regex_val);
    const UChar* const string = (const UChar*)String_val(string_val);
    const uintnat string_length = caml_string_length(string_val);

    OnigRegion* const region = onig_region_new();
    if (region == NULL) {
        caml_raise_out_of_memory();
    }
    const int result = onig_scan(
        regex,
        string,
        string + string_length,
        region,
        Long_val(options_val),
        scan_callback_trampoline,
        &callback_val);
    onig_region_free(region, 1);
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    CAMLreturn(Val_int(result));
}

CAMLprim value ocaml_onig_get_match_stack_limit_size(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_long(onig_get_match_stack_limit_size()));
}

CAMLprim value ocaml_onig_set_match_stack_limit_size(value size_val)
{
    CAMLparam1(size_val);
    onig_set_match_stack_limit_size((unsigned int)Long_val(size_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_get_retry_limit_in_match(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_long(onig_get_retry_limit_in_match()));
}

CAMLprim value ocaml_onig_set_retry_limit_in_match(value limit_val)
{
    CAMLparam1(limit_val);
    onig_set_retry_limit_in_match((unsigned long)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_get_retry_limit_in_search(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_long(onig_get_retry_limit_in_search()));
}

CAMLprim value ocaml_onig_set_retry_limit_in_search(value limit_val)
{
    CAMLparam1(limit_val);
    onig_set_retry_limit_in_search((unsigned long)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_get_parse_depth_limit(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_long(onig_get_parse_depth_limit()));
}

CAMLprim value ocaml_onig_set_parse_depth_limit(value depth_val)
{
    CAMLparam1(depth_val);
    onig_set_parse_depth_limit((unsigned int)Long_val(depth_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_set_capture_num_limit(value num_val)
{
    CAMLparam1(num_val);
    onig_set_capture_num_limit(Int_val(num_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_get_subexp_call_limit_in_search(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_long(onig_get_subexp_call_limit_in_search()));
}

CAMLprim value ocaml_onig_set_subexp_call_limit_in_search(value limit_val)
{
    CAMLparam1(limit_val);
    onig_set_subexp_call_limit_in_search((unsigned long)Long_val(limit_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_get_subexp_call_max_nest_level(value unit)
{
    CAMLparam1(unit);
    CAMLreturn(Val_int(onig_get_subexp_call_max_nest_level()));
}

CAMLprim value ocaml_onig_set_subexp_call_max_nest_level(value level_val)
{
    CAMLparam1(level_val);
    onig_set_subexp_call_max_nest_level(Int_val(level_val));
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_number_of_names(value regex_val)
{
    CAMLparam1(regex_val);
    CAMLreturn(Val_int(onig_number_of_names(get_regex(regex_val))));
}

CAMLprim value ocaml_onig_number_of_capture_histories(value regex_val)
{
    CAMLparam1(regex_val);
    CAMLreturn(Val_int(onig_number_of_capture_histories(get_regex(regex_val))));
}

CAMLprim value ocaml_onig_noname_group_capture_is_active(value regex_val)
{
    CAMLparam1(regex_val);
    CAMLreturn(Val_bool(onig_noname_group_capture_is_active(
        get_regex(regex_val))));
}

CAMLprim value ocaml_onig_get_options(value regex_val)
{
    CAMLparam1(regex_val);
    CAMLreturn(Val_long(onig_get_options(get_regex(regex_val))));
}

static int foreach_name_trampoline(
    const UChar* name,
    const UChar* name_end,
    int ngroup_num,
    int* group_nums,
    OnigRegex regex,
    void* arg)
{
    (void)regex;
    CAMLparam0();
    CAMLlocal3(callback, name_val, arr_val);

    callback = *(value*)arg;

    name_val =
        caml_alloc_initialized_string(name_end - name, (const char*)name);
    arr_val = caml_alloc(ngroup_num, 0);
    for (int i = 0; i < ngroup_num; ++i) {
        Store_field(arr_val, i, Val_int(group_nums[i]));
    }

    value result_val = caml_callback2(callback, name_val, arr_val);
    CAMLreturnT(int, Bool_val(result_val) ? 0 : 1);
}

CAMLprim value
ocaml_onig_foreach_name(value regex_val, value callback_val)
{
    CAMLparam2(regex_val, callback_val);
    onig_foreach_name(
        get_regex(regex_val), foreach_name_trampoline, &callback_val);
    CAMLreturn(Val_unit);
}

CAMLprim value ocaml_onig_name_to_backref_number(
    value regex_val,
    value name_val,
    value region_val)
{
    CAMLparam3(regex_val, name_val, region_val);
    regex_t* const regex = get_regex(regex_val);
    const UChar* const name = (const UChar*)String_val(name_val);
    const uintnat name_length = caml_string_length(name_val);
    const int result = onig_name_to_backref_number(
        regex, name, name + name_length, Region_val(region_val));
    if (result < 0) {
        UChar err_buf[ONIG_MAX_ERROR_MESSAGE_LEN];
        onig_error_code_to_str(err_buf, result);
        caml_raise_with_string(*ocaml_onig_Error_exn, (const char*)err_buf);
    }
    CAMLreturn(Val_int(result));
}
