//
//  ViewController.m
//  hero apps exe1 wolverine
//
//  Created by Ishay on 5/16/18.
//  Copyright © 2018 Ishay. All rights reserved.
//

#import "ViewController.h"
#import "Hero.h"
#import "Movie.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    
}

// an array of Heroes in case there will be more then one hero in the future
@property (strong, nonatomic) NSMutableArray<Hero *> *heroesGlobal;
@property (strong, nonatomic) NSMutableArray<Movie *> *moviesGlobal;


@property (weak, nonatomic) IBOutlet UITableView *tableViewDetailes;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMovies;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //MARK:- need to make this the name of wolverine and the titles to big and center
    self.navigationItem.title = @"Hero";
    
    
    [self fetchHeroUsingJSON];
    
}

- (void)fetchHeroUsingJSON {
    NSLog(@"Fetching courses...");
    
    NSString *urlString = @"https://heroapps.co.il/employee-tests/ios/logan.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
               NSLog(@"finished fetching the hero data");
               
               NSError *err;
               
               NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
               NSLog(@"%@",jsonDict);
               
               if (err) {
                   NSLog(@"Failed To Serialize int JSON: %@", err);
                   return ;
               }
               
               
               //Creating a local heroes array
               NSMutableArray<Hero *> *heroesLocal = NSMutableArray.new;
               
               // fetching all the data with key value pairs and arrays
               NSDictionary *dataArray = [jsonDict objectForKey:@"data"];
               NSString *actorName = [dataArray objectForKey:@"actorName"];
               NSString *name = [dataArray objectForKey:@"name"];
               NSString *nickName = [dataArray objectForKey:@"nickname"];
               NSString *imageURL = [dataArray objectForKey:@"image"];
               NSNumber *yearBorn = [dataArray objectForKey:@"dateOfBirth"];
               
               //powers array
               NSMutableArray *powersJSON = [dataArray objectForKey:@"powers"];
            
               NSMutableString *stringOfPowersArray = [[NSMutableString alloc]init];
               for(int i=0; i< powersJSON.count; i++){
                   NSMutableString *power = [powersJSON objectAtIndex: i];

                   [stringOfPowersArray appendString: power];
                   
                   if(i == powersJSON.count - 1){
                       //do nothing
                   } else {
                       [stringOfPowersArray appendString: @", "];
                   }
                
                   
               }
               //*********************************************//
               
               
               
               //movies array
               NSMutableArray *moviesJSON = [dataArray objectForKey:@"movies"];
               
               NSMutableArray * moviesArr = [[NSMutableArray alloc]init];
               for(int i=0; i< moviesJSON.count; i++){
                   Movie *movie = Movie.new;
                   movie.nameOfMovie = [[moviesJSON objectAtIndex: i] objectForKey:@"name"];
                   movie.yearOfPublish = [[moviesJSON objectAtIndex: i] objectForKey:@"year"];
        
                   [moviesArr addObject: movie];
               }
               //*********************************************//
               
               
               
               Hero *hero = Hero.new;
               hero.actorName = actorName;
               hero.name = name;
               hero.nickName = nickName;
               hero.imageURL = imageURL;
               hero.yearBorn = yearBorn;
               hero.powersArr = stringOfPowersArray;
               hero.moviesArr = moviesArr;
               [heroesLocal addObject:hero];
               
               NSLog(@"%@", heroesLocal);
               
               self.heroesGlobal = heroesLocal;
               self.moviesGlobal = moviesArr;
               
               dispatch_async(dispatch_get_main_queue(),^{
                   [self.tableViewMovies reloadData];
                   [self.tableViewDetailes reloadData];
                   self.navigationItem.title = hero.name;
               });
               
               
           }]resume];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableViewDetailes) {
        return 4;
    }
    else
        if (tableView == _tableViewMovies) {
            return _heroesGlobal[0].moviesArr.count;
        }
    return -1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView == _tableViewDetailes) {
        static NSString *cellDetailes = @"cellForDetailes";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailes];
        
        return cell;
    }
    else
         {
             
             static NSString *cellMovies = @"cellForMovies";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMovies];
             
             cell.textLabel.text = _moviesGlobal[indexPath.row].nameOfMovie;
             cell.detailTextLabel.text = [_moviesGlobal[indexPath.row].yearOfPublish stringValue];
             
             return cell;
             
        }

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
