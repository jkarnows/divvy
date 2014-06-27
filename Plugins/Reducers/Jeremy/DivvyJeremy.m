//
//  DivvyNilReducer.m
//  Divvy
//
//  Created by Joshua Lewis on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DivvyJeremy.h"

#import "DivvyDataset.h"


@implementation DivvyJeremy

@dynamic reducerID;
@dynamic name;

@dynamic d;

- (void) awakeFromInsert {
  [super awakeFromInsert];
  
  self.name = @"Jeremy";
  self.reducerID = [[NSProcessInfo processInfo] globallyUniqueString];
}

- (void) calculateD:(DivvyDataset *)dataset {
  if([dataset.d compare:self.d] == NSOrderedAscending)
    self.d = dataset.d;
}

- (void) reduceDataset:(DivvyDataset *)dataset
           reducedData:(NSData *)reducedData {
  int n = [dataset.n intValue];
  int d = [dataset.d intValue];
  int reducedD = [self.d intValue];
  
  float *data = [dataset floatData];
  
  // reducedData is by default the first two dimensions scaled to be between
  // 0 and 1
  float min, max, value;
  min = FLT_MAX;
  max = FLT_MIN;
  for(int i = 0; i < n; i++)
    for(int j = 0; j < reducedD; j++) {
      value = data[i * d + j];
      if(value < min)
        min = value;
      if(value > max)
        max = value;
  }

  float *newReducedData = (float *)[reducedData bytes];
  
  for(int i = 0; i < n; i++)
    for(int j = 0; j < reducedD; j++)
      newReducedData[i * reducedD + j] = (data[i * d + j] - min) / (max - min);
}

@end
