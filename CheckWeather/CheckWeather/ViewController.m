

//
//  ViewController.m
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"
#import "CWWebServiceHandler.h"
#import "ConstantUrl.h"
#import "CustomTableCellTableViewCell.h"
#import "DetailViewController.h"
@interface ViewController ()
@property(nonatomic,strong)NSString *strLatitude,*strLongitude;

@property (nonatomic,strong)LocationManager *myLocation;
@property (nonatomic,strong)CWWebServiceHandler *webServicehandler;
@property (nonatomic,strong)IBOutlet UILabel *lblWeatherStatus;
@property (nonatomic,strong)IBOutlet UITableView *tblview;
@property (nonatomic,strong)IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *strHumidity,*strDate,*strSummary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myLocation=[[LocationManager alloc]init];
    self.myLocation.delegate=self;
}

- (void)myCurrentLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    _strLatitude=latitude;
    _strLongitude=longitude;
     [self.activityIndicator startAnimating];
    [self callWeatherResult];

}
-(void)callWeatherResult
{
    
    NSString *urlStr=[NSString stringWithFormat:Weather_Url,Weather_API_Key,
                      _strLatitude,_strLongitude];
    
    [[CWWebServiceHandler alloc] initConnection:urlStr method:HTTPMethodGet completionHandler:^(NSData *data,NSHTTPURLResponse *response)
    
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
            arrayCurrent=[dict valueForKey:@"currently"];
            arrayhourly=[[dict valueForKey:@"hourly"]valueForKey:@"data"];
            arrayDaily=[[dict valueForKey:@"daily"]valueForKey:@"data"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.tblview reloadData];
            [self.activityIndicator setHidden:YES];
            [self.activityIndicator stopAnimating];
            [self.activityIndicator hidesWhenStopped];
        
            });
           
        }
    failure:^(NSError *error)
    {
        [self.activityIndicator setHidden:YES];
        [self.activityIndicator stopAnimating];
        [self.activityIndicator hidesWhenStopped];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(IS_OS_8_OR_LATER)
            {
                UIAlertController *alertController = [UIAlertController
                                                      alertControllerWithTitle:AlertErrorTitle
                                                      message:AlertMessage
                                                      preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction
                                               actionWithTitle:NSLocalizedString(@"OK", @"Cancel action")
                                               style:UIAlertActionStyleCancel
                                               handler:^(UIAlertAction *action)
                                               {
                                                   
                                               }];
                
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:AlertErrorTitle message:AlertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                
                [alert show];
            }
        });
    }];


}

#pragma mark:todo

#pragma mark-Tableview Delegate and Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Currently";
            break;
        case 1:
            sectionName = @"Hourly";
            break;
        case 2:
            sectionName = @"Daily";
             break;
        default:
            
            break;
    }
    return sectionName;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 0)];
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    header.backgroundColor = [UIColor grayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 260, 25)];
    label.font = [UIFont boldSystemFontOfSize:18.0f];
    label.backgroundColor = [UIColor clearColor];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.textColor = [UIColor blackColor];
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(1.0, 1.0);
    [header addSubview:label];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    return 1;
    else if(section==1)
    return [arrayhourly count];
    else if (section==2)
    return [arrayDaily count];
    else
        return 0;
    
}
-(NSString*)getMyDateandTime:(double)unixValue
{
    double unixTimestamp=unixValue;
    NSTimeInterval _interval=unixTimestamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSString *stringFromDate = [NSString stringWithFormat:@"Date:-%@",date];
    stringFromDate = [stringFromDate substringToIndex:25];
    return stringFromDate;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CheckWeatherIdentifier = @"CustomCell";
    
    CustomTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CheckWeatherIdentifier];
    
    if (cell == nil) {
        cell = [[CustomTableCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CheckWeatherIdentifier];
    }
    if(indexPath.section==0)
    {
        cell.summaryLabel.text = [NSString stringWithFormat:@"Weather %@",[arrayCurrent valueForKey:@"summary"]];
        
       NSString *strDate= [self getMyDateandTime:[[arrayCurrent valueForKey:@"time"]doubleValue]];
       cell.dateLabel.text=[NSString stringWithFormat:@"Time %@",strDate];
       cell.humidityLabel.text=[NSString stringWithFormat:@"Humidity %@",[arrayCurrent valueForKey:@"humidity"]];

      
    }
    if(indexPath.section==1)
    {
     
        cell.summaryLabel.text = [NSString stringWithFormat:@"Weather %@",[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"summary"]];
        NSString *strDate= [self getMyDateandTime:[[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"time"]doubleValue]];
        
        cell.dateLabel.text=[NSString stringWithFormat:@"Time %@",strDate];
        cell.humidityLabel.text=[NSString stringWithFormat:@"Humidity %@",[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"humidity"]];
           
      
    }
    if(indexPath.section==2)
    {
        
        cell.summaryLabel.text = [NSString stringWithFormat:@"Weather %@",[[arrayDaily objectAtIndex:indexPath.row] valueForKey:@"summary"]];
        NSString *strDate= [self getMyDateandTime:[[[arrayDaily objectAtIndex:indexPath.row ] valueForKey:@"time"]doubleValue]];
        
        cell.dateLabel.text=[NSString stringWithFormat:@"Time %@",strDate];
        cell.humidityLabel.text=[NSString stringWithFormat:@"Humidity %@",[[arrayDaily objectAtIndex:indexPath.row] valueForKey:@"humidity"]];
     
    
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //DetailViewController *detailViewController = [[DetailViewController alloc] init];
    if(indexPath.section==0)
    {
       _strSummary = [NSString stringWithFormat:@"Weather %@",[arrayCurrent valueForKey:@"summary"]];
         NSString *strDate= [self getMyDateandTime:[[arrayCurrent  valueForKey:@"time"]doubleValue]];
        _strDate=[NSString stringWithFormat:@"Time %@",strDate];
         _strHumidity=[NSString stringWithFormat:@"Humidity %@",[arrayCurrent valueForKey:@"humidity"]];
        
    }
    if(indexPath.section==1)
    {
         _strSummary = [NSString stringWithFormat:@"Weather %@",[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"summary"]];
        NSString *strDate= [self getMyDateandTime:[[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"time"]doubleValue]];
        _strDate=[NSString stringWithFormat:@"Time %@",strDate];
        _strHumidity=[NSString stringWithFormat:@"Humidity %@",[[arrayhourly objectAtIndex:indexPath.row ] valueForKey:@"humidity"]];
    }
    if(indexPath.section==2)
    {
        _strSummary = [NSString stringWithFormat:@"Weather %@",[[arrayDaily objectAtIndex:indexPath.row] valueForKey:@"summary"]];
        NSString *strDate= [self getMyDateandTime:[[[arrayDaily objectAtIndex:indexPath.row ] valueForKey:@"time"]doubleValue]];
        
        _strDate=[NSString stringWithFormat:@"Time %@",strDate];
        
        _strHumidity=[NSString stringWithFormat:@"Humidity %@",[[arrayDaily objectAtIndex:indexPath.row] valueForKey:@"humidity"]];
    }
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
    //[self.navigationController pushViewController:detailViewController animated:YES];
   // [self presentViewController:detailViewController animated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailViewController = (DetailViewController *)[segue destinationViewController];

    detailViewController.strSummary = _strSummary;
    
    detailViewController.strDate=_strDate;
    detailViewController.strhumidity=_strHumidity;
}

@end
