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
#import "FullImageViewController.h"
#import "MoviesTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    
}

// an array of Heroes in case there will be more then one hero in the future
@property (strong, nonatomic) NSMutableArray<Hero *> *heroesGlobal;
@property (strong, nonatomic) NSMutableArray<Movie *> *moviesGlobal;



@property (weak, nonatomic) IBOutlet UITableView *tableViewMovies;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _heroImage.layer.cornerRadius = _heroImage.bounds.size.height / 2;
    _heroImage.clipsToBounds = YES;
    
    [self fetchHeroUsingJSON];
}


- (void)fetchHeroUsingJSON {
    NSLog(@"Fetching courses...");
    
    NSString *urlJSONString = @"https://heroapps.co.il/employee-tests/ios/logan.json";
    NSURL *urlJSON = [NSURL URLWithString:urlJSONString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:urlJSON
           completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
               NSLog(@"finished fetching the hero data");
               
               NSError *err;
               
               NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
//               NSLog(@"%@",jsonDict);
               
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
                   
                   if(i < powersJSON.count - 1){
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
               
               
               //creating a single hero and appending it to the heros array
               Hero *hero = Hero.new;
               hero.actorName = actorName;
               hero.name = name;
               hero.nickName = nickName;
               hero.imageURL = imageURL;
               hero.yearBorn = yearBorn;
               hero.powersArr = stringOfPowersArray;
               hero.moviesArr = moviesArr;
               [heroesLocal addObject:hero];
               
               
               //populating the global arrays with the local one's
               self.heroesGlobal = heroesLocal;
               self.moviesGlobal = moviesArr;
      
               
               // using async thread to make sure that all the tables populated on time and not blocking the main thread
               dispatch_async(dispatch_get_main_queue(),^{
                   [self.tableViewMovies reloadData];
                   self.navigationItem.title = hero.name;
                   self.nickNameDetail.text = hero.nickName;
                   self.yearBornDetail.text = [hero.yearBorn stringValue];
                   self.powersDetail.text = hero.powersArr;
                   self.originalActorDetail.text = hero.actorName;
                   
                   self.heroImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL ]]];
               });
               
           }]resume];
    
    
    //Add a tap gesture to the imageView
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [_heroImage setUserInteractionEnabled:YES];
    [_heroImage addGestureRecognizer:singleTap];
   
}

// tapping on the image will send it to the next view
-(void)tapDetected{
    NSLog(@"*****tapped On THE Image view*****");
     
    [self performSegueWithIdentifier:@"sagueToImage" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    FullImageViewController *fullImageController;
    fullImageController = [segue destinationViewController];
    fullImageController.fullSizeImage = self.heroImage.image;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _heroesGlobal[0].moviesArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MoviesTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (!movieCell) {
        [tableView registerNib:[UINib nibWithNibName:@"MoviesTableViewCell" bundle:nil] forCellReuseIdentifier:@"movieCell"];
        
        movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
        
    }
    
        movieCell.nameOfMovie.text = _moviesGlobal[indexPath.row].nameOfMovie;
        movieCell.yearOfMovie.text = [_moviesGlobal[indexPath.row].yearOfPublish stringValue];
    
        return movieCell;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
