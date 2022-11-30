package com.richclub.liver
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity
import com.tencent.effect.tencent_effect_flutter.XmagicProcesserFactory;
import com.tencent.live.TXLivePluginManager;
class MainActivity: FlutterActivity() {
     override fun onCreate( savedInstanceState: Bundle?) {
         super.onCreate(savedInstanceState);
          TXLivePluginManager.register( XmagicProcesserFactory());
          
     }
}
