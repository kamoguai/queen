// 1
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  // 1
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    AppLocalizations? appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);

    print("kevinxlhua${appLocalizations == null}");
    return appLocalizations;
  }

  Map<String, Map<String, String>> _localizedStrings = {};

  // 3
  Future loadJson() async {
    final jsonString = await rootBundle.loadString("assets/labels/i18n.json");
    Map<String, dynamic> map = json.decode(jsonString);
    _localizedStrings =
        map.map((key, value) => MapEntry(key, value.cast<String, String>()));
  }

  String? get noneLabel => _localizedStrings[locale.languageCode]!["none"];

  String? get motion2dLabel =>
      _localizedStrings[locale.languageCode]!["motion_2d_label"];

  String? get motion3dLabel =>
      _localizedStrings[locale.languageCode]!["motion_3d_label"];

  String? get motionhandLabel =>
      _localizedStrings[locale.languageCode]!["motion_hand_label"];

  String? get motionganLabel =>
      _localizedStrings[locale.languageCode]!["motion_gan_label"];

  String? get segmentationCustomLabel =>
      _localizedStrings[locale.languageCode]!["segmentation_custom_label"];

  String? get xmagicPannelTab1 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab1"];

  String? get xmagicPannelTab2 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab2"];

  String? get xmagicPannelTab3 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab3"];

  String? get xmagicPannelTab4 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab4"];

  String? get xmagicPannelTab5 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab5"];

  String? get xmagicPannelTab6 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab6"];

  String? get xmagicPannelTab7 =>
      _localizedStrings[locale.languageCode]!["xmagic_pannel_tab7"];

  String? get autohtinBodyStrengthLabel =>
      _localizedStrings[locale.languageCode]!["autohtin_body_strength_label"];

  String? get bodyLegStretchLabel =>
      _localizedStrings[locale.languageCode]!["body_leg_stretch_label"];

  String? get bodySlimLegStrengthLabel =>
      _localizedStrings[locale.languageCode]!["body_slim_leg_strength_label"];

  String? get bodyWaishStrengthLabel =>
      _localizedStrings[locale.languageCode]!["body_waish_strength_label"];

  String? get bodyThinShoulderStrengthLabel => _localizedStrings[
      locale.languageCode]!["body_thin_shoulder_strength_label"];

  String? get bodySlimHeadStrengthLabel =>
      _localizedStrings[locale.languageCode]!["body_slim_head_strength_label"];

  String? get segmentations =>
      _localizedStrings[locale.languageCode]!["segmentations"];

  String? get makeups => _localizedStrings[locale.languageCode]!["makeups"];

  String? get motions => _localizedStrings[locale.languageCode]!["motions"];

  String? get luts => _localizedStrings[locale.languageCode]!["luts"];

  //????????????????????????
  //??????
  String? get beautyWhitenLabel =>
      _localizedStrings[locale.languageCode]!["beauty_whiten_label"];

  //??????
  String? get beautySmoothLabel =>
      _localizedStrings[locale.languageCode]!["beauty_smooth_label"];

  //??????
  String? get beautyRuddyLabel =>
      _localizedStrings[locale.languageCode]!["beauty_ruddy_label"];

  //?????????
  String? get imageContrastLabel =>
      _localizedStrings[locale.languageCode]!["image_contrast_label"];

  //?????????
  String? get imageSaturationLabel =>
      _localizedStrings[locale.languageCode]!["image_saturation_label"];

  //?????????
  String? get imageSharpenLabel =>
      _localizedStrings[locale.languageCode]!["image_sharpen_label"];

  //??????
  String? get beautyEnlargeeyeLabel =>
      _localizedStrings[locale.languageCode]!["beauty_enlarge_eye_label"];

  //??????
  String? get beautyThinFaceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_thin_face_label"];

  //??????-> ??????
  String? get beautyThinFace1Label =>
      _localizedStrings[locale.languageCode]!["beauty_thin_face1_label"];

  //?????? ->??????
  String? get beautyThinFace2Label =>
      _localizedStrings[locale.languageCode]!["beauty_thin_face2_label"];
  //?????? - ?????????
  String? get beautyThinFace3Label =>
      _localizedStrings[locale.languageCode]!["beauty_thin_face3_label"];
  //V???
  String? get beautyVFaceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_v_face_label"];
  //??????
  String? get beautyNarrowFaceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_narrow_face_label"];
  //??????
  String? get beautyShortFaceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_short_face_label"];
  //??????
  String? get beautyBasicFaceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_basic_face_label"];
  //??????
  String? get beautyLipsLabel =>
      _localizedStrings[locale.languageCode]!["beauty_lips_label"];
  //??????->?????????
  String? get beautyLips1Label =>
      _localizedStrings[locale.languageCode]!["beauty_lips1_label"];
  //??????->?????????
  String? get beautyLips2Label =>
      _localizedStrings[locale.languageCode]!["beauty_lips2_label"];
  //??????->?????????
  String? get beautyLips3Label =>
      _localizedStrings[locale.languageCode]!["beauty_lips3_label"];
  //??????->?????????
  String? get beautyLips4Label =>
      _localizedStrings[locale.languageCode]!["beauty_lips4_label"];
  //??????->?????????
  String? get beautyLips5Label =>
      _localizedStrings[locale.languageCode]!["beauty_lips5_label"];
  //??????
  String? get beautyRedcheeksLabel =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks_label"];
  //??????->??????
  String? get beautyRedcheeks1Label =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks1_label"];
  //??????->??????
  String? get beautyRedcheeks2Label =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks2_label"];
  //??????->??????
  String? get beautyRedcheeks3Label =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks3_label"];
  //??????->??????
  String? get beautyRedcheeks4Label =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks4_label"];
  //??????->??????
  String? get beautyRedcheeks5Label =>
      _localizedStrings[locale.languageCode]!["beauty_redcheeks5_label"];
  //??????
  String? get beautyLitiLabel =>
      _localizedStrings[locale.languageCode]!["beauty_liti_label"];
  //??????->??????
  String? get beautyLiti1Label =>
      _localizedStrings[locale.languageCode]!["beauty_liti1_label"];
  //??????->??????
  String? get beautyLiti2Label =>
      _localizedStrings[locale.languageCode]!["beauty_liti2_label"];
  //??????->??????
  String? get beautyLiti3Label =>
      _localizedStrings[locale.languageCode]!["beauty_liti3_label"];
  //??????->??????
  String? get beautyLiti4Label =>
      _localizedStrings[locale.languageCode]!["beauty_liti4_label"];
  //?????????
  String? get beautyThinCheekLabel =>
      _localizedStrings[locale.languageCode]!["beauty_thin_cheek_label"];
  //??????
  String? get beautyChinLabel =>
      _localizedStrings[locale.languageCode]!["beauty_chin_label"];
  //??????
  String? get beautyForeheadLabel =>
      _localizedStrings[locale.languageCode]!["beauty_forehead_label"];
  //??????
  String? get beautyEyeLightenLabel =>
      _localizedStrings[locale.languageCode]!["beauty_eye_lighten_label"];
  //??????
  String? get beautyEyeDistanceLabel =>
      _localizedStrings[locale.languageCode]!["beauty_eye_distance_label"];
  //??????
  String? get beautyEyeAngleLabel =>
      _localizedStrings[locale.languageCode]!["beauty_eye_angle_label"];
  //??????
  String? get beautyThinNoseLabel =>
      _localizedStrings[locale.languageCode]!["beauty_thin_nose_label"];
  //??????
  String? get beautyNoseWingLabel =>
      _localizedStrings[locale.languageCode]!["beauty_nose_wing_label"];
  //????????????
  String? get beautyNosePositionLabel =>
      _localizedStrings[locale.languageCode]!["beauty_nose_position_label"];
  //??????
  String? get beautyToothBeautyLabel =>
      _localizedStrings[locale.languageCode]!["beauty_tooth_beauty_label"];
  //??????
  String? get beautyRemovePounchLabel =>
      _localizedStrings[locale.languageCode]!["beauty_remove_pounch_label"];
  //????????????
  String? get beautyWrinkleSmoothLabel =>
      _localizedStrings[locale.languageCode]!["beauty_wrinkle_smooth_label"];
  //?????????
  String? get beautyRemoveEyePouchLabel =>
      _localizedStrings[locale.languageCode]!["beauty_remove_eye_pouch_label"];
  //??????
  String? get beautyLipShapeLabel =>
      _localizedStrings[locale.languageCode]!["beauty_mouth_size_label"];
  //????????????
  String? get beautylipHeightLabel =>
      _localizedStrings[locale.languageCode]!["beauty_mouth_height_label"];

  String? get getDemoLiveLabel1 =>
      _localizedStrings[locale.languageCode]!["demo_live_label1"];
  String? get getDemoLiveLabel2 =>
      _localizedStrings[locale.languageCode]!["demo_live_label2"];
  String? get getDemoLiveLabel3 =>
      _localizedStrings[locale.languageCode]!["demo_live_label3"];
  String? get getDemoLiveLabel4 =>
      _localizedStrings[locale.languageCode]!["demo_live_label4"];
  String? get getDemoLiveLabel5 =>
      _localizedStrings[locale.languageCode]!["demo_live_label5"];

}
