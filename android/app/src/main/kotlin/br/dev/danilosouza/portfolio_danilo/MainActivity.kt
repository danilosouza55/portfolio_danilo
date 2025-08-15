package br.dev.danilosouza.portfolio_danilo

import android.os.Bundle
import android.os.Build
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Configura a decoração da janela para edge-to-edge
        WindowCompat.setDecorFitsSystemWindows(window, false)
        
        // Usa as novas APIs para Android 15+
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            // Obtém o controlador de WindowInsets
            val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
            
            // Define a visibilidade e aparência das barras do sistema
            windowInsetsController.apply {
                isAppearanceLightStatusBars = false // ou true, dependendo do seu tema
                isAppearanceLightNavigationBars = false // ou true, dependendo do seu tema
            }
        }
        
        super.onCreate(savedInstanceState)
    }
}
