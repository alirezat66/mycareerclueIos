//
//  DataService.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
class DataService {
    static let instance = DataService()
    
   /* private let collections = [
      /*  Collection(fName: "علیرضا", lName: "تقی زاده", title: "برنامه نویسی اندروید", price: "رایگان", place: "تهران", numberOfPost: 5, img: "myImage.jpg"),
        Collection(fName: "حسن", lName: "حسینی", title: "مدیریت", price: "۱۲۰۰۰ تومان", place: "واشنگتن", numberOfPost: 12, img: "myImage.jpg"),
        Collection(fName: "آرزو", lName: "اقبالی", title: "گرافیک بازی", price: "رایگان", place: "تهران", numberOfPost: 5, img: "myImage.jpg"),
        Collection(fName:"رحیم", lName: "حسینی", title: "مدیریت", price: "۱۴... تومان", place: "واشنگتن", numberOfPost: 12, img: "myImage.jpg")*/
    ]
    */
    private let contents = [
        Content(fName: "علیرضا", lName: "تقی زاده", education: "کارشناس ارشد", location: "تهران", collectionName: "", title: "عنوان مطلب ۱", contentText:"کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.", contentType: 2, linkAddress: "https://www.nature.com/articles/nature26142", likeByMe: false, imgSource: "https://www.weyoumaster.com/img/__mco/publishing/5_u_1_2.jpg", hasMore: true, price: "رایگان",ownerPic: "myImage.jpg"),
        Content(fName: "علیرضا", lName : "حسنی", education: "کارشناس ارشد", location: "تهران", collectionName: "", title: "عنوان مطلب ۱", contentText:"کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع", contentType: 1, linkAddress: "https://www.nature.com/articles/nature26142", likeByMe: false, imgSource: "", hasMore: true, price: "۱۴ هزار تومان",ownerPic: "myImage.jpg"),
    Content(fName: "علیرضا", lName: "تقی زاده", education: "کارشناس ارشد", location: "تهران", collectionName: "", title: "عنوان مطلب ۳", contentText:"کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.", contentType: 1, linkAddress: "https://www.nature.com/articles/nature26142", likeByMe: false, imgSource: "https://www.weyoumaster.com/img/__mco/publishing/5_u_1_2.jpg", hasMore: true, price: "رایگان",ownerPic: "myImage.jpg")
        ,Content(fName: "علیرضا", lName: "تقی زاده", education: "کارشناس ارشد", location: "تهران", collectionName: "", title: "عنوان مطلب ۴", contentText:"کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی و فرهنگ پیشرو در زبان فارسی ایجاد کرد. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.", contentType: 1, linkAddress: "https://www.nature.com/articles/nature26142", likeByMe: false, imgSource: "https://www.weyoumaster.com/img/__mco/publishing/5_u_1_2.jpg", hasMore: true, price: "رایگان",ownerPic: "myImage.jpg")
    ]
    
    private let ConversationList = [Conversation(fName: "علیرضا", lName: "تقی زاده", shortText: "سلام چطوری از مقالت ممنونم", lblTime: "۲۸ دقیقه پیش", count: "12", imgSource: "myImage.jpg")
    ,Conversation(fName: "حسن", lName: "محمدی", shortText: "تولدت مبارک باشه برادر", lblTime: "۴ روز پیش", count: "1", imgSource: "myImage.jpg")
    ,Conversation(fName: "آرزو", lName: "بابایی", shortText: "خوبی علیرضا جان مقالتو خوندم", lblTime: "۱ ماه پیش", count: "22", imgSource: "myImage.jpg")]
    
    
    private let MessageList = [Message(mid: "asds", user: User(id: "1", name: "علیرضا", avatar: "myImage.jpg", online: false), content: "سلام چطوری خوبی چه خبری خوش می گذره", date: "", type: 1) ,
              Message(mid: "asds", user: User(id: "2", name: "علیرضا", avatar: "myImage.jpg", online: false), content:"سلام خوبی چه خبر خوش می گذره خوبی سلام تو سیس سی یس سی یس سی شسمشک شس شس کشسم شس کشس شسم ک", date: "", type: 1),
              Message(mid: "asds", user: User(id: "2", name: "علیرضا", avatar: "myImage.jpg", online: false), content: "ghorboonet che khabar", date: "", type: 1),
              Message(mid: "asds", user: User(id: "1", name: "علیرضا", avatar: "myImage.jpg", online: false), content: "khoobi khosh migzare oza chetoori", date: "", type: 1)
    ]
    
    func getMessages() -> [Message] {
        return MessageList
    }
    func getConversation() ->[Conversation] {
        return ConversationList
    }
    
 /*   func getCollections() -> [Collection] {
        return nil
    }*/
    func getContent() -> [Content] {
        return contents
    }
}
