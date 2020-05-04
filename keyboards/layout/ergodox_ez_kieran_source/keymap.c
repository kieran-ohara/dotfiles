#include QMK_KEYBOARD_H
#include "version.h"
#include "keymap_german.h"
#include "keymap_nordic.h"
#include "keymap_french.h"
#include "keymap_spanish.h"
#include "keymap_hungarian.h"
#include "keymap_swedish.h"
#include "keymap_br_abnt2.h"
#include "keymap_canadian_multilingual.h"
#include "keymap_german_ch.h"
#include "keymap_jp.h"
#include "keymap_bepo.h"
#include "keymap_italian.h"
#include "keymap_slovenian.h"
#include "keymap_danish.h"
#include "keymap_norwegian.h"
#include "keymap_portuguese.h"

#define KC_MAC_UNDO LGUI(KC_Z)
#define KC_MAC_CUT LGUI(KC_X)
#define KC_MAC_COPY LGUI(KC_C)
#define KC_MAC_PASTE LGUI(KC_V)
#define KC_PC_UNDO LCTL(KC_Z)
#define KC_PC_CUT LCTL(KC_X)
#define KC_PC_COPY LCTL(KC_C)
#define KC_PC_PASTE LCTL(KC_V)
#define ES_LESS_MAC KC_GRAVE
#define ES_GRTR_MAC LSFT(KC_GRAVE)
#define ES_BSLS_MAC ALGR(KC_6)
#define NO_PIPE_ALT KC_GRAVE
#define NO_BSLS_ALT KC_EQUAL

enum custom_keycodes {
  RGB_SLD = EZ_SAFE_RANGE,
  HSV_172_255_255,
  HSV_86_255_128,
  ST_MACRO_0,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [0] = LAYOUT_ergodox_pretty(
    KC_MINUS,       KC_1,           KC_2,           KC_3,           KC_4,           KC_5,           WEBUSB_PAIR,                                    RESET,          KC_6,           KC_7,           KC_8,           KC_9,           KC_0,           KC_EQUAL,
    LGUI(KC_SPACE), KC_Q,           KC_W,           KC_E,           KC_R,           KC_T,           KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_Y,           KC_U,           KC_I,           KC_O,           KC_P,           KC_BSLASH,
    MT(MOD_HYPR, KC_ESCAPE),KC_A,           KC_S,           KC_D,           KC_F,           KC_G,                                                                           KC_H,           KC_J,           KC_K,           KC_L,           LT(2,KC_SCOLON),LGUI_T(KC_QUOTE),
    KC_LSHIFT,      LCTL_T(KC_Z),   KC_X,           KC_C,           KC_V,           KC_B,           LCTL(LGUI(KC_SPACE)),                                KC_TRANSPARENT, KC_N,           KC_M,           KC_COMMA,       KC_DOT,         RCTL_T(KC_SLASH),KC_RSHIFT,
    LT(1,KC_GRAVE), KC_QUOTE,       ST_MACRO_0,     KC_MEDIA_PREV_TRACK,KC_MEDIA_NEXT_TRACK,                                                                                                KC_BRIGHTNESS_UP,KC_BRIGHTNESS_DOWN,KC_LBRACKET,    KC_RBRACKET,    MO(1),
                                                                                                    LSFT(KC_LGUI),  KC_LGUI,        KC_MEDIA_PLAY_PAUSE,LGUI(KC_GRAVE),
                                                                                                                    KC_LALT,        KC_AUDIO_VOL_UP,
                                                                                    KC_SPACE,       KC_BSPACE,      KC_LCTRL,       KC_AUDIO_VOL_DOWN,KC_TAB,         KC_ENTER
  ),
  [1] = LAYOUT_ergodox_pretty(
    KC_ESCAPE,      KC_F1,          KC_F2,          KC_F3,          KC_F4,          KC_F5,          KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_F6,          KC_F7,          KC_F8,          KC_F9,          KC_F10,         KC_F11,
    KC_TRANSPARENT, KC_EXLM,        KC_DLR,         KC_LCBR,        KC_RCBR,        KC_PIPE,        KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_UP,          KC_7,           KC_8,           KC_9,           KC_ASTR,        KC_F12,
    KC_TRANSPARENT, KC_HASH,        KC_PIPE,        KC_MINUS,       KC_EQUAL,       KC_GRAVE,                                                                       KC_DOWN,        KC_4,           KC_5,           KC_6,           KC_PLUS,        KC_TRANSPARENT,
    KC_TRANSPARENT, KC_PERC,        KC_CIRC,        KC_LBRACKET,    KC_RBRACKET,    KC_TILD,        KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_AMPR,        KC_1,           KC_2,           KC_3,           KC_BSLASH,      KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                                                                                 KC_TRANSPARENT, KC_DOT,         KC_0,           KC_EQUAL,       KC_TRANSPARENT,
                                                                                                    RGB_MOD,        HSV_172_255_255,RGB_TOG,        RGB_SLD,
                                                                                                                    HSV_86_255_128, KC_TRANSPARENT,
                                                                                    RGB_VAD,        RGB_VAI,        HSV_86_255_128, KC_TRANSPARENT, RGB_HUD,        RGB_HUI
  ),
  [2] = LAYOUT_ergodox_pretty(
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, LGUI(KC_LEFT),  KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, LALT(KC_RIGHT), KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                 KC_TRANSPARENT, LGUI(KC_C),     LGUI(KC_Z),     TO(0),          KC_TRANSPARENT, LGUI(KC_V),     KC_TRANSPARENT,
    KC_TRANSPARENT, LGUI(KC_RIGHT), KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                                                 KC_LEFT,        KC_DOWN,        KC_UP,          KC_RIGHT,       KC_TRANSPARENT, KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_DELETE,      LGUI(LSFT(KC_RIGHT)),KC_TRANSPARENT, LALT(KC_LEFT),  KC_TRANSPARENT,                                 KC_TRANSPARENT, LGUI(KC_G),     KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, LGUI(KC_F),     KC_TRANSPARENT,
    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,                                                                                                 KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
                                                                                                    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT,
                                                                                                                    KC_TRANSPARENT, KC_TRANSPARENT,
                                                                                    KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT, KC_TRANSPARENT
  ),
};


extern bool g_suspend_state;
extern rgb_config_t rgb_matrix_config;

void keyboard_post_init_user(void) {
  rgb_matrix_enable();
}

const uint8_t PROGMEM ledmap[][DRIVER_LED_TOTAL][3] = {
    [0] = { {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214}, {122,157,214} },

    [1] = { {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224}, {0,220,224} },

    [2] = { {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171}, {88,170,171} },

};

void set_layer_color(int layer) {
  for (int i = 0; i < DRIVER_LED_TOTAL; i++) {
    HSV hsv = {
      .h = pgm_read_byte(&ledmap[layer][i][0]),
      .s = pgm_read_byte(&ledmap[layer][i][1]),
      .v = pgm_read_byte(&ledmap[layer][i][2]),
    };
    if (!hsv.h && !hsv.s && !hsv.v) {
        rgb_matrix_set_color( i, 0, 0, 0 );
    } else {
        RGB rgb = hsv_to_rgb( hsv );
        float f = (float)rgb_matrix_config.hsv.v / UINT8_MAX;
        rgb_matrix_set_color( i, f * rgb.r, f * rgb.g, f * rgb.b );
    }
  }
}

void rgb_matrix_indicators_user(void) {
  if (g_suspend_state || keyboard_config.disable_layer_led) { return; }
  switch (biton32(layer_state)) {
    case 0:
      set_layer_color(0);
      break;
    case 1:
      set_layer_color(1);
      break;
    case 2:
      set_layer_color(2);
      break;
   default:
    if (rgb_matrix_get_flags() == LED_FLAG_NONE)
      rgb_matrix_set_color_all(0, 0, 0);
    break;
  }
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case ST_MACRO_0:
    if (record->event.pressed) {
      SEND_STRING(SS_LGUI(SS_TAP(X_DOT)));

    }
    break;
    case RGB_SLD:
      if (record->event.pressed) {
        rgblight_mode(1);
      }
      return false;
    case HSV_172_255_255:
      if (record->event.pressed) {
        rgblight_mode(1);
        rgblight_sethsv(172,255,255);
      }
      return false;
    case HSV_86_255_128:
      if (record->event.pressed) {
        rgblight_mode(1);
        rgblight_sethsv(86,255,128);
      }
      return false;
  }
  return true;
}

uint32_t layer_state_set_user(uint32_t state) {

  uint8_t layer = biton32(state);

  ergodox_board_led_off();
  ergodox_right_led_1_off();
  ergodox_right_led_2_off();
  ergodox_right_led_3_off();
  switch (layer) {
    case 1:
      ergodox_right_led_1_on();
      break;
    case 2:
      ergodox_right_led_2_on();
      break;
    case 3:
      ergodox_right_led_3_on();
      break;
    case 4:
      ergodox_right_led_1_on();
      ergodox_right_led_2_on();
      break;
    case 5:
      ergodox_right_led_1_on();
      ergodox_right_led_3_on();
      break;
    case 6:
      ergodox_right_led_2_on();
      ergodox_right_led_3_on();
      break;
    case 7:
      ergodox_right_led_1_on();
      ergodox_right_led_2_on();
      ergodox_right_led_3_on();
      break;
    default:
      break;
  }
  return state;
};
