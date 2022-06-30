/*package com.sharvayainfotech.eofficedesk

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin


class Application : FlutterApplication(), PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
    }
}*/

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.ContentResolver
import android.content.Intent
import android.media.AudioAttributes
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Vibrator
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.sharvayainfotech.eofficedesk.MainActivity
import com.sharvayainfotech.eofficedesk.NotificationActivity
import com.sharvayainfotech.eofficedesk.R
import io.flutter.embedding.android.FlutterActivity
import java.io.File
import java.util.*


class FireBaseMessagingServices : FirebaseMessagingService() {
    var uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
    private val vib: Vibrator? = null
    var NOTIFICATION_CHANNEL_NAME = "Default"
    var notificationId = Random().nextInt() // just use a counter in some util class...
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        //  Log.d("firebasemessage456", "Title : " + remoteMessage.getNotification().getTitle() + "Discription : " + remoteMessage.getNotification().getBody());
        Log.d("firebasemessage", "Title : " + remoteMessage.data)
        //Map<String, String> params = new HashMap<String, String>();
        if (remoteMessage.data != null && remoteMessage.data.size > 0) {
            Log.d(TAG, "Message data payload: " + remoteMessage.data)
            val title = remoteMessage.data["title"].toString()
            val msg = remoteMessage.data["body"].toString()

          createNotification(title, msg)
        }

    }

    override fun onNewToken(token: String) {
        Log.d("Token123", "Refreshed token: $token")

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
        Log.d("RefredgToken", token //FirebaseInstanceId.getInstance().getToken();
                + "")
      /*  val tokenpref = applicationContext.getSharedPreferences(getString(R.string.FCM_SERVER), MODE_PRIVATE)
        val tokenpref_Editor = tokenpref.edit()
        tokenpref_Editor.putString(getString(R.string.FCM_Token), token //FirebaseInstanceId.getInstance().getToken();
        )*/


        /*  SharedPreferences prefs = getApplicationContext().getSharedPreferences("DeviceToken", Context.MODE_PRIVATE);
        CompanyID = prefs.getInt("CompanyID", 0);
        SharedPreferences prefs2 =getApplicationContext().getSharedPreferences("UserDeviceToken", Context.MODE_PRIVATE);
        UserID = prefs2.getInt("UserID", 0);
        UserName = prefs2.getString("UserName", "");
        if(!receivedToken.equals(""))
        {
            Log.d("RefredgTokennotempty", receivedToken + "");

            api_for_Update_Token(UserName,CompanyID,receivedToken);
        }*/
    }

    fun createNotification(title123: String, body123: String) {
      /*  val remoteViews = RemoteViews(packageName, R.layout.custom_notification)
        remoteViews.setTextViewText(R.id.txt_title, title123)
        remoteViews.setTextViewText(R.id.txt_body, body123)*/
        Log.d("notific456", "$title123 BODY :  $body123")
        val intent = Intent(this, FlutterActivity::class.java)
        intent.putExtra("title", title123)
        intent.putExtra("body", body123)
        intent.action = java.lang.Long.toString(System.currentTimeMillis())
        val contentIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_ONE_SHOT)

        val mNotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val mBuilder = NotificationCompat.Builder(this, default_notification_channel_id)
        mBuilder.setContentTitle(body123)
        mBuilder.setStyle(NotificationCompat.InboxStyle())
        mBuilder.setContentText(title123)
        mBuilder.setTicker("Notification Listener Service Example")
        if (title123 == "FollowUp") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "1"
        } else if (title123 == "Inquiry") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "2"
        } else if (title123 == "External Lead") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "3"
        } else if (title123 == "Inquiry Share") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "4"
        } else if (title123 == "To-Do") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "5"
        } else if (title123 == "Leave Request") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "6"
        } else if (title123 == "Quotation") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "7"
        } else if (title123 == "Sales Order") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "8"
        } else if (title123 == "Sales Order Approval") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "9"
        } else if (title123 == "FollowUp Reminder") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "10"
        } else if (title123 == "ComplaintVisit Reminder") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "11"
        } else if (title123 == "Complaint") {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "12"
        } else {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo)
            NOTIFICATION_CHANNEL_ID1 = "001"
        }
        mBuilder.setAllowSystemGeneratedContextualActions(true)
        //  mBuilder.setCustomContentView(remoteViews);
        mBuilder.setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
        mBuilder.setContentIntent(contentIntent)
        mBuilder.setAutoCancel(true)

        // mBuilder.setDefaults(DEFAULT_SOUND);
        //  Uri uri= RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        mBuilder.setSound(null)
        val dismissIntent: PendingIntent = NotificationActivity.getDismissIntent(notificationId, applicationContext)
        //mBuilder.addAction(R.drawable.ic_msg, "Mark As Read", dismissIntent);
        mBuilder.setDeleteIntent(dismissIntent)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_ALARM)
                    .build()
            //  mNotificationManager.deleteNotificationChannel(NOTIFICATION_CHANNEL_ID);
            val notificationChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID1, title123, importance)
            notificationChannel.setSound(null, null)
            // notificationChannel.setSound(uri,null);
            // RingtoneManager.getRingtone(this, Uri.parse("android.resource://dhruveni.crm.dhruvenicrmNative/raw/bell_in_temple.mp3")).play();
            //Log.d("ksdjf123", Constant.notificationUri.getPath())

            //  notificationChannel.setSound(Constant.notificationUri,audioAttributes);
            mBuilder.setChannelId(NOTIFICATION_CHANNEL_ID1)
            assert(mNotificationManager != null)
            mNotificationManager.createNotificationChannel(notificationChannel)
        }
        assert(mNotificationManager != null)
        mNotificationManager.notify(System.currentTimeMillis().toInt(), mBuilder.build())
    }

    fun getRawUri(filename: String): Uri {
        return Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + File.pathSeparator + File.separator + packageName + "/raw/" + filename)
    }

    companion object {
        const val TAG = "TokenGenration"
        const val NOTIFICATION_CHANNEL_ID = "10001"
        var NOTIFICATION_CHANNEL_ID1 = "10001"
        private const val default_notification_channel_id = "default"
        var ringUri34 //=Uri.parse("android.resource://dhruveni.crm.dhruvenicrmNative/"+R.raw.bell_in_temple);
                : Uri? = null
    }
}
