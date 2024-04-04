package com.spine.iuml_membership

//import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.net.Uri
import android.text.TextUtils
import android.util.Log
import android.webkit.WebView
import android.widget.Toast
import androidx.core.content.FileProvider
//import com.payu.base.models.ErrorResponse
//import com.payu.base.models.PayUPaymentParams
//import com.payu.checkoutpro.PayUCheckoutPro
//import com.payu.checkoutpro.utils.PayUCheckoutProConstants
//import com.payu.checkoutpro.utils.PayUCheckoutProConstants.CP_HASH_NAME
//import com.payu.checkoutpro.utils.PayUCheckoutProConstants.CP_HASH_STRING
//import com.payu.ui.model.listeners.PayUCheckoutProListener
//import com.payu.ui.model.listeners.PayUHashGenerationListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private lateinit var channel:MethodChannel
    private val TAG = "CheckShameem"
    private lateinit var _result: MethodChannel.Result


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,"payuGateway")
        channel.setMethodCallHandler{ call ,result ->
            _result =result





            if (call.method=="GPay"){

                _result =result
                val arguments = call.arguments<Map <String,String>>() as Map <String,String>
                var uriPara= ""
                uriPara= arguments["Uri"] .toString()


                val uri = Uri.parse(uriPara)

                val intent = Intent(Intent.ACTION_VIEW)
                intent.setData(uri)
                intent.setPackage("com.google.android.apps.nbu.paisa.user")
                if (intent.resolveActivity(getPackageManager()) != null) {
                    println("I am learning Kotlin. "+intent)
                    startActivityForResult(intent, 1)
                }

                else{
                    _result.success("NoApp")
                }



            }
            else if (call.method=="BHIM"){


                _result =result
                val arguments = call.arguments<Map <String,String>>() as Map <String,String>
                var uriPara= ""
                uriPara= arguments["Uri"] .toString()


                val uri = Uri.parse(uriPara)

                val intent = Intent(Intent.ACTION_VIEW)
                intent.setData(uri)
                intent.setPackage("in.org.npci.upiapp")
                if (intent.resolveActivity(getPackageManager()) != null) {
                    startActivityForResult(intent, 1)
                }else{
                    _result.success("NoApp")
                }

            }
            else if (call.method=="Paytm"){


                _result =result
                val arguments = call.arguments<Map <String,String>>() as Map <String,String>
                var uriPara= ""
                uriPara= arguments["Uri"] .toString()


                val uri = Uri.parse(uriPara)

                val intent = Intent(Intent.ACTION_VIEW)
                intent.setData(uri)
                intent.setPackage("net.one97.paytm")
                if (intent.resolveActivity(getPackageManager()) != null) {
                    startActivityForResult(intent, 1)
                }else{
                    _result.success("NoApp")
                }

            }       else if (call.method=="PhonePe"){


                _result =result
                val arguments = call.arguments<Map <String,String>>() as Map <String,String>
                var uriPara= ""
                uriPara= arguments["Uri"] .toString()


                val uri = Uri.parse(uriPara)

                val intent = Intent(Intent.ACTION_VIEW)
                intent.setData(uri)
                intent.setPackage("com.phonepe.app")
                if (intent.resolveActivity(getPackageManager()) != null) {
                    startActivityForResult(intent, 1)
                }else{
                    _result.success("NoApp")
                }

            }

            else if (call.method=="ShareQr"){

                _result =result
                val arguments = call.arguments<Map <String,String>>() as Map <String,String>
                var path= ""
                var app= ""
                path= arguments["path"].toString()
                app= arguments["app"].toString()
                shareFile(path,app)




            }


            else{
                result.notImplemented()

            }
        }
    }




//    fun preparePayUBizParams(amount: String, phone: String, name: String, txnId: String): PayUPaymentParams {
//        return PayUPaymentParams.Builder().setAmount(amount)
//            .setIsProduction(false)
//            .setKey("7rnFly")
//            .setProductInfo("Donation")
//            .setPhone(phone)
//            .setTransactionId(txnId)
//            .setFirstName(name)
//            .setEmail("spinegeneral@gmail.com")
//            .setSurl("https://haddiyya-1b794-default-rtdb.firebaseio.com/Success")
//            .setFurl("https://haddiyya-1b794-default-rtdb.firebaseio.com/Failure")
//            .build()
//    }


    private fun shareFile(path: String, app: String) {
        val imageFile = File(this.applicationContext.cacheDir, path)
        val contentUri: Uri = FileProvider.getUriForFile(this, BuildConfig.APPLICATION_ID + ".provider", imageFile)
        val intent = Intent(Intent.ACTION_SEND)
        intent.setPackage(app)
        intent.type = "image/jpeg"
        intent.putExtra(Intent.EXTRA_STREAM, contentUri)
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)


        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivityForResult(intent, 1)
        }else{
            _result.success("NoApp")

        }

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.d(TAG, "onActivityResult: requestCode: $requestCode")
        Log.d(TAG, "onActivityResult: resultCode: $resultCode")

        if (data != null && requestCode == 1 ) {

            Log.d(TAG, "onActivityResult: data: " + data.getStringExtra("response"))
            val res = data.getStringExtra("response")
            if(res!=null){
                val search = "SUCCESS"
                try {
                    if(res!=null&&res!=""){
                        if (res!!.toLowerCase().contains(search.toLowerCase())) {
                            try {
                                _result.success(res)
//                                _result.success("FAILED")
                            }catch (ex:Exception){
//                                _result.success("FAILED")
                            }
//                            Toast.makeText(this, "Challange Successful", Toast.LENGTH_SHORT).show()
                        } else {
                            try {
                                _result.success("FAILED")

                            }catch (ex:Exception){
//                                _result.success("FAILED")
                            }




//                            Toast.makeText(this, "Challange Failed", Toast.LENGTH_SHORT).show()
                        }
                    }else{
                        _result.success("FAILED")
                    }

                }catch (ex:Exception){
                    try {
                        _result.success("FAILED")

                    }catch (ex:Exception){
//                        _result.success("FAILED")
                    }


                }
            }else{
                try {
                    _result.success("FAILED")

                }catch (ex:Exception){
//                        _result.success("FAILED")
                }



            }



        }else{
            try {
                _result.success("FAILED")

            }catch (ex:Exception){
//                _result.success("FAILED")
            }

        }
    }
}
