package com.sharvayainfotech.eofficedesk;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.AudioAttributes;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;
import android.os.Vibrator;
import android.util.Log;
import android.widget.RemoteViews;

import androidx.core.app.NotificationCompat;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;


import java.io.File;
import java.util.ArrayList;
import java.util.Random;



public class FireBaseMessagingServices extends FirebaseMessagingService {

    public static final String TAG = "TokenGenration";
    Uri uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
    private Vibrator vib;
    public static final String NOTIFICATION_CHANNEL_ID = "10001" ;
    public static  String NOTIFICATION_CHANNEL_ID1 = "10001" ;

    private final static String default_notification_channel_id = "default" ;
    String NOTIFICATION_CHANNEL_NAME = "Default";

    public static Uri ringUri34 ;//=Uri.parse("android.resource://dhruveni.crm.dhruvenicrmNative/"+R.raw.bell_in_temple);

    public  int notificationId = new Random().nextInt(); // just use a counter in some util class...

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        //  Log.d("firebasemessage456", "Title : " + remoteMessage.getNotification().getTitle() + "Discription : " + remoteMessage.getNotification().getBody());
        Log.d("firebasemessage", "Title : " + remoteMessage.getData());
        //Map<String, String> params = new HashMap<String, String>();
        if (remoteMessage.getData()!=null && remoteMessage.getData().size() > 0) {
            Log.d(TAG, "Message data payload: " + remoteMessage.getData());
            String title = remoteMessage.getData().get("title").toString();
            String msg = remoteMessage.getData().get("body").toString();









            createNotification(title,msg);
        }

    }

    @Override
    public void onNewToken(String token) {
        Log.d("Token123", "Refreshed token: " + token);

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.

        String receivedToken = token;//FirebaseInstanceId.getInstance().getToken();

        Log.d("RefredgToken", receivedToken + "");



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

    public void createNotification(String title123, String body123) {



        Log.d("notific456",title123 +  " BODY :  "+ body123);


        Intent intent = new Intent(this, MainActivity.class);
        intent.putExtra("title", title123);
        intent.putExtra("body", body123);
        intent.setAction(Long.toString(System.currentTimeMillis()));


        final PendingIntent contentIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_ONE_SHOT);



        NotificationManager mNotificationManager = (NotificationManager)
                getSystemService( NOTIFICATION_SERVICE ) ;

        NotificationCompat.Builder mBuilder = new
                NotificationCompat.Builder( this, default_notification_channel_id ) ;
        mBuilder.setContentTitle(title123) ;
        mBuilder.setStyle( new NotificationCompat.InboxStyle()) ;
        mBuilder.setContentText(body123) ;
        mBuilder.setTicker( "Notification Listener Service Example" ) ;
        if(title123.equals("FollowUp"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "1";
        }
        else  if(title123.equals("Inquiry"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "2";

        }
        else if(title123.equals("External Lead"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "3";

        }
        else if(title123.equals("Inquiry Share"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "4";

        }
        else if(title123.equals("To-Do"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "5";


        }
        else if(title123.equals("Leave Request"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "6";


        }
        else if(title123.equals("Quotation"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "7";

        }
        else if(title123.equals("Sales Order"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "8";

        }
        else if(title123.equals("Sales Order Approval"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "9";

        }
        else if(title123.equals("FollowUp Reminder"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "10";

        }
        else if(title123.equals("ComplaintVisit Reminder"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "11";

        }
        else if(title123.equals("Complaint"))
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "12";

        }
        else
        {
            mBuilder.setSmallIcon(R.drawable.sharvaya_logo) ;
            NOTIFICATION_CHANNEL_ID1 = "001";

        }
        mBuilder.setAllowSystemGeneratedContextualActions(true);
        //  mBuilder.setCustomContentView(remoteViews);
        mBuilder.setVisibility(NotificationCompat.VISIBILITY_PUBLIC);
        mBuilder.setContentIntent(contentIntent);
        mBuilder.setAutoCancel(true);

        // mBuilder.setDefaults(DEFAULT_SOUND);
        //  Uri uri= RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);

        mBuilder.setSound(null);



        PendingIntent dismissIntent = NotificationActivity.getDismissIntent(notificationId, getApplicationContext());
        //mBuilder.addAction(R.drawable.ic_msg, "Mark As Read", dismissIntent);
        mBuilder.setDeleteIntent(dismissIntent);


        if (Build.VERSION. SDK_INT >= Build.VERSION_CODES. O ) {
            int importance = NotificationManager.IMPORTANCE_DEFAULT ;

            AudioAttributes audioAttributes = new AudioAttributes.Builder()
                    .setContentType(AudioAttributes. CONTENT_TYPE_SONIFICATION )
                    .setUsage(AudioAttributes. USAGE_ALARM )
                    .build() ;
            //  mNotificationManager.deleteNotificationChannel(NOTIFICATION_CHANNEL_ID);

            NotificationChannel notificationChannel = new
                    NotificationChannel( NOTIFICATION_CHANNEL_ID1 , title123 , importance) ;
            notificationChannel.setSound(null,null);
            // notificationChannel.setSound(uri,null);
            // RingtoneManager.getRingtone(this, Uri.parse("android.resource://dhruveni.crm.dhruvenicrmNative/raw/bell_in_temple.mp3")).play();


            //  notificationChannel.setSound(Constant.notificationUri,audioAttributes);

            mBuilder.setChannelId( NOTIFICATION_CHANNEL_ID1) ;
            assert mNotificationManager != null;
            mNotificationManager.createNotificationChannel(notificationChannel) ;
        }
        assert mNotificationManager != null;

        mNotificationManager.notify(( int ) System. currentTimeMillis () ,mBuilder.build()) ;
    }

    public Uri getRawUri(String filename) {
        return Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + File.pathSeparator + File.separator + getPackageName() + "/raw/" + filename);
    }

}