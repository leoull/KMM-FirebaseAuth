package comm.kmm.login.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import comm.kmm.login.FirebaseAuthentication
import kotlinx.coroutines.launch

class MainActivity : ComponentActivity() {
    private val auth = FirebaseAuth()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MyApplicationTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                    LoginUI(auth)
                }
            }
        }
    }
}

@Composable
fun LoginUI(authRepo: FirebaseAuth) {
    val scope = rememberCoroutineScope()
    var loginResultStr by remember { mutableStateOf("") }

    Column(
        modifier = Modifier.fillMaxSize(),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Button(
            onClick = {
                scope.launch {
                    authRepo.login() { username ->
                        loginResultStr = username
                    }
                }
            }
        ) {
            Text(
                "LOG IN",
                fontWeight = FontWeight.Normal
            )
        }
        Text(
            loginResultStr,
            fontWeight = FontWeight.Normal
        )
    }

}

class FirebaseAuth(
    private val auth: FirebaseAuthentication = FirebaseAuthentication(),
) {
    suspend fun login(userName: (String) -> Unit) {
        val result = auth.loginWithEmailAndPass("teset@gmail.com", "pass")
        userName(result)
        println("User Login Data: $result")
    }
}
