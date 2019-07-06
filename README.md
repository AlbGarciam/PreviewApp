# PreviewApp

**Important!**

In order to be able to use view videos, you should use a push notification. You can use the following sample:
```javascript
{
    "aps" : {
        "content-available" : 1
    },
    "playlist": {
        "f61c3d7f92b199ed7f5812781ccba06f": {
            "title": "Superb sunset - Miami Beach 2017",
            "url": "https://static.xtrea.mr/media/sample1.mp4"
        },
        "05747156e369eff34cbecb40a2adda6a": {
            "title": "Unicorns and horses spining around",
            "url": "https://static.xtrea.mr/media/sample2.mp4"
        },
        "9f49077a912f958530060272d6d60d30": {
            "title": "Sam Smith, Normani - Dancing With A Stranger",
            "subtitle": "Official video (Ft. Normani)",
            "url": "https://static.xtrea.mr/media/sample3.mp4"
        },
        "f3058e6662927f1fcd17840469cfd5f3": {
            "title": "Tulips",
            "url": "https://static.xtrea.mr/media/sample4.mp4"
        }
    }
}
```

This notification will trigger a job to download all items on playlist and store them on Documents directory. Once this task is finished, it will send a notification to the user.

In order to send notifications, you can use [this](https://github.com/onmyway133/PushNotifications) project.

![](GifSample.gif)
