//
//  AddProductVC.m
//  TianlangStar
//
//  Created by youyousiji on 16/11/7.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddProductVC.h"
#import "HttpTool.h"
#import "ProductModel.h"
@interface AddProductVC ()


/** 上传商品的名称 */
@property (nonatomic,strong) NSArray *fileArr;

@end

@implementation AddProductVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加商品----过
//    [self addProduct];
    
    //添加服务
    [self addServices];
    
    //获取所有商品及服务---过  记得更改type
//    [self getAllProduct];
    

}





-(NSArray *)fileArr
{
    if (!_fileArr)
    {
        _fileArr = @[@"shappic",@"picstyle",@"locationpic"];
    }
    return _fileArr;
}





/** 添加商品接口测试 */
-(void)addProduct
{
    
    
    /*地    址:	http://192.168.10.114:8080/carservice/releasecommodityservlet
     需要参数:	String sessionId用户登录标记
     商品：
     String type 商品分类  1商品  2 服务
     String productname 商品名称
     long price 商品价格
     Long scoreprice 积分价格
     String inventory 商品库存
     String images 商品图片
    
     Int resultCode  1000表示成功
     Int resultCode  1005未知错误
     Int resultCode  1007用户没有登录
     Int resultCode  1016用户没有权限
     Int resultCode  1018添加没有成功

     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"1";
    parmas[@"productname"]  = @"机油432r";
    parmas[@"price"]  = @"190";
    parmas[@"scoreprice"]  = @"2000";
    parmas[@"inventory"]  = @"200";

    YYLog(@"商品发布parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];

    [[AFHTTPSessionManager manager]POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        UIImage *image1 = [UIImage imageNamed:@"homePage_normal"];
        UIImage *image2 = [UIImage imageNamed:@"homePage_normal"];
        UIImage *image3 = [UIImage imageNamed:@"homePage_normal"];
        
        NSArray *imagesArr = [NSArray arrayWithObjects:image1,image2,image3, nil];
        
        NSUInteger i = 0 ;
        
        YYLog(@"imagesArr.count---%lu",(unsigned long)imagesArr.count);
        
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imagesArr)
        {
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            //拼接data
            [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"添加商品responseObject--%@",responseObject);
        NSNumber *num = responseObject[@"resultCode"];

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
           YYLog(@"添加商品error--%@",error);
    }];
}


/** 添加服务 */
-(void)addServices
{
    /*
     地    址:	http://192.168.10.114:8080/carservice/releasecommodityservlet
     需要参数:	String sessionId用户登录标记
     商品：
     汽车服务：
     String type 商品分类
     String services 服务名称
     Long price 服务价格
     Long scoreprice 积分价格
     String images 图片
     */
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"2";
    parmas[@"services"]  = @"服务";
    parmas[@"price"]  = @"1090";
    parmas[@"scoreprice"]  = @"99000";
    
    YYLog(@"商品发布parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasecommodityservlet",URL];
    
    [[AFHTTPSessionManager manager]POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         UIImage *image1 = [UIImage imageNamed:@"homePage_normal"];
         UIImage *image2 = [UIImage imageNamed:@"homePage_normal"];
         UIImage *image3 = [UIImage imageNamed:@"homePage_normal"];
         
         NSArray *imagesArr = [NSArray arrayWithObjects:image1,image2,image3, nil];
         
         NSUInteger i = 0 ;
         
         YYLog(@"imagesArr.count---%lu",(unsigned long)imagesArr.count);
         
         /**出于性能考虑,将上传图片进行压缩*/
         for (UIImage * image in imagesArr)
         {
             NSData *data = UIImageJPEGRepresentation(image, 1.0);
             //拼接data
             [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
             i++;
         }
     } progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         YYLog(@"添加服务responseObject--%@",responseObject);
         
         NSNumber *num = responseObject[@"resultCode"];
         NSInteger result = [num integerValue];
         if (result == 1007)
         {
             [[AlertView sharedAlertView] loginUpdataSession];
         }
         
         
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         YYLog(@"添加服务error--%@",error);
     }];
}


/** 
  *获取所有商品列表
  */
-(void)getAllProduct
{
    /*
     http://192.168.10.114:8080/carservice/getcommodityinfoservlet
     String sessionId用户登录标记
     String currentPage 当前页
     String type 商品类型(1 商品 2 汽车服务)
     根据type类型获取所有商品信息
     获取的数据进行分页
     Int resultCode  1000表示成功
     Int resultCode  1001数据库没有这条数据
     Int resultCode  1005未知错误
     Int resultCode  1007用户没有登录
     Int resultCode  1016用户没有权限
     */
    
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"currentPage"]  = @"1";
    parmas[@"type"]  = @"2";
    
    YYLog(@"获取所有商品列表parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@getcommodityinfoservlet",URL];
    
    
    [HttpTool post:url parmas:parmas success:^(id json)
     {
         YYLog(@"%@",json);
         
         NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:json[@"obj"]];
         
         ProductModel *model = arr[0];
         YYLog(@"model---%ld",(long)model.scoreprice);
         
    } failure:^(NSError *error) {
        YYLog(@"%@",error);
        
    }];
}


-(void)updataProduct
{
    /*
     String sessionId用户登录标记
     商品：
     String type 商品分类
     String id 商品数据库编码
     String productname 商品名称
     long price 商品价格
     Long scoreprice 积分价格
     String inventory 商品库存
     String images 商品图片
     汽车服务：
     String type 商品分类
     String id 汽车服务数据库编码
     String services 服务名称
     Long price 服务价格
     Long scoreprice 积分价格
     String images 图片
     */
    
    

    


}


@end
