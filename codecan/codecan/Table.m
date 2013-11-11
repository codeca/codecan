//
//  Table.m
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Table.h"

@class Port;

@implementation Table

-(id)init{
	
	self = [super init];
	
	self.deck = [[DevelopmentCards alloc] initDeck];
	
	self.hexes = [[NSMutableArray alloc] init];
	self.vertexes = [[NSMutableArray alloc] init];
	self.edges = [[NSMutableArray alloc] init];
	
	NSMutableArray * resources = [[NSMutableArray alloc] init];
	NSArray *numbers = @[@5, @2, @6, @3, @8, @10, @9, @12, @11, @4, @8, @10, @9, @4, @5, @6, @3, @11];
	
	for(Resource i =1 ; i<7; i++){
		switch (i) {
			case DESERT:
				[resources addObject:[NSNumber numberWithInt:DESERT]];
				break;
			case WOOL:
				[resources addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:WOOL], [NSNumber numberWithInt:WOOL], [NSNumber numberWithInt:WOOL],[NSNumber numberWithInt:WOOL],nil]];
				break;
			case BRICK:
				[resources addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:BRICK], [NSNumber numberWithInt:BRICK], [NSNumber numberWithInt:BRICK],nil]];
				break;
			case GRAIN:
				[resources addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:GRAIN], [NSNumber numberWithInt:GRAIN], [NSNumber numberWithInt:GRAIN],[NSNumber numberWithInt:GRAIN],nil]];
				break;
			case ORE:
				[resources addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:ORE], [NSNumber numberWithInt:ORE], [NSNumber numberWithInt:ORE],nil]];
				break;
			case LUMBER:
				[resources addObjectsFromArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:LUMBER], [NSNumber numberWithInt:LUMBER], [NSNumber numberWithInt:LUMBER], [NSNumber numberWithInt:LUMBER],nil]];
				break;
			default:
				break;
		}
	}
	
	for(int i=0;i<resources.count;i++){
		[resources exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform(19)];
	}
	
	
	if(self){
		
		
		// Declaracao dos HEX
		for(int i=0; i<19; i++){
			
			//inicializa os HEx e os coloca na posicao que serao mostrados.
			
			HexagonNode *aux = [[HexagonNode alloc] initWithResource:[[resources lastObject] integerValue]];
			[resources removeLastObject];
			
			aux.name = [NSString stringWithFormat:@"Hex%i", i];
			
			if(i<1)
				aux.position = CGPointMake(0, 0);
			if(i>=1 && i<7)
				aux.position = CGPointMake(0+133*cos((i-1)*M_PI/3), 0+133*sin((i-1)*M_PI/3));
			if(i>=7 && !(i%2))
				aux.position = CGPointMake(0+230*cos((i-7)*M_PI/6), 0+230*sin((i-7)*M_PI/6));
			else if(i>=7)
				aux.position = CGPointMake(0+266*cos((i-7)*M_PI/6), 0+266*sin((i-7)*M_PI/6));
			
			//Coloca uma skin nos Hex
			//Mudar esse codigo para colocar as tiles certas depois!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			
			[self.hexes addObject:aux];
			
		}
		
		
		
		int counter = 0;
		
		
		for(int i = 7;i<19;i++){
			if([(HexagonNode *)[self.hexes objectAtIndex:i] resource] != DESERT){
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = [(NSNumber*)[numbers objectAtIndex:counter] integerValue];
				counter++;
			}
			else{
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = 7;
				self.thief = ((HexagonNode *)[self.hexes objectAtIndex:i]);
			}
			SKLabelNode * numberLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
			numberLabel.fontSize = 30;
			numberLabel.text = [[NSString alloc] initWithFormat:@"%d", ((HexagonNode *)[self.hexes objectAtIndex:i]).number];
			[(HexagonNode *)[self.hexes objectAtIndex:i] addChild:numberLabel];
		}
		
		for(int i=1; i<7 ; i++){
			if([(HexagonNode *)[self.hexes objectAtIndex:i] resource] != DESERT){
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = [(NSNumber*)[numbers objectAtIndex:counter] integerValue];
				counter++;
			}
			else{
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = 7;
				self.thief = ((HexagonNode *)[self.hexes objectAtIndex:i]);
			}
			SKLabelNode * numberLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
			numberLabel.fontSize = 30;
			numberLabel.text = [[NSString alloc] initWithFormat:@"%d", ((HexagonNode *)[self.hexes objectAtIndex:i]).number];
			[(HexagonNode *)[self.hexes objectAtIndex:i] addChild:numberLabel];
		}
		
		if([(HexagonNode *)[self.hexes objectAtIndex:0] resource] != DESERT){
			((HexagonNode *)[self.hexes objectAtIndex:0]).number = 11;
		}else{
			((HexagonNode *)[self.hexes objectAtIndex:0]).number = 7;
			self.thief = ((HexagonNode *)[self.hexes objectAtIndex:0]);
		}

		SKLabelNode * numberLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
		numberLabel.fontSize = 30;
		numberLabel.text = [[NSString alloc] initWithFormat:@"%d", ((HexagonNode *)[self.hexes objectAtIndex:0]).number];
		[(HexagonNode *)[self.hexes objectAtIndex:0] addChild:numberLabel];
			
		
		
		//Declaracao dos Vertex
		for(int i=0; i<54; i++){
			VertexNode * newVertex = [[VertexNode alloc] init];
			newVertex.name = [[NSString alloc] initWithFormat:@"vertex%d",i];
			[self.vertexes addObject:newVertex];
			
		}
		
		//Declaracao dos Edges
		for(int i=0; i<72; i++){
			EdgeNode * newEdge = [[EdgeNode alloc] init];
			newEdge.name = [[NSString alloc] initWithFormat:@"edge%d",i];
			[self.edges addObject:newEdge];
		}
		
		
		
		//Leitura do CSV dos Hexagonos
		NSString *path =[[NSBundle mainBundle] pathForResource:@"hexCSV" ofType:@".csv"];
		NSArray *csvHex = [FileReader createTableFromFile:path];
		
		
		
		//Relacionar os Vertex e os Edges com os Hexagonos
		for(int i=0; i<self.hexes.count; i++){
			HexagonNode* hex= self.hexes[i];
			
			NSDictionary* dictio = csvHex[i];
			
			NSArray* indexesVertices = [dictio objectForKey:@"Vertex"];
			
			for(NSString* stringIndex in indexesVertices){
				int index = [stringIndex intValue];
				[hex.vertexes addObject:[self.vertexes objectAtIndex:index]];
			}
			
			
			NSArray* indexesEdges = [dictio objectForKey:@"Edge"];
			
			for(NSString* stringIndex in indexesEdges){
				int index = [stringIndex intValue];
				[hex.edges addObject:[self.edges objectAtIndex:index]];
			}
			
		}
		
		
		//Ler CSV dos Vertex
		path =[[NSBundle mainBundle] pathForResource:@"verticeCSV" ofType:@".csv"];
		NSArray *csvVertex = [FileReader createTableFromFile:path];
		
		//Relacionar os Edges com os vertex
		
		for(int i=0; i<self.vertexes.count; i++){
			VertexNode* vertex= self.vertexes[i];
			
			NSDictionary* dictio = csvVertex[i];
			
			NSArray* indexEdges = [dictio objectForKey:@"Edge"];
			
			for(NSString* stringIndex in indexEdges){
				int index = [stringIndex intValue];
				if(index>=0)
					[vertex.edges addObject:[self.edges objectAtIndex:index]];
			}
			
		}
		
		for(VertexNode *vertex in self.vertexes){
			for(EdgeNode *edge in vertex.edges){
				[edge.vertexes addObject:vertex];
			}
		}
		
		for(HexagonNode *hex in self.hexes){
		
			for(int i = 0 ; i < 6 ; i++){
				// verificar esse cast
				((VertexNode *)[hex.vertexes objectAtIndex:i]).position =CGPointMake(hex.position.x+77*cos(M_PI/6+i*M_PI/3), hex.position.y+77*sin(M_PI/6+i*M_PI/3));
				
				((EdgeNode *)[hex.edges objectAtIndex:i]).position =CGPointMake(hex.position.x+77*pow(3, 0.5)/2*cos(i*M_PI/3), hex.position.y+77*pow(3, 0.5)/2*sin(i*M_PI/3));
				((EdgeNode *)[hex.edges objectAtIndex:i]).zRotation = i*M_PI/3;
			}
			
		}
		
			//Inicializa os portos e os randomiza
			
			NSMutableArray* AuxPorts = [[NSMutableArray alloc]init];
			
			for (int aux = 0; aux < 4; aux++) {
				
				[AuxPorts addObject:[[Port alloc ]initWithType: STANDARD withResource: 0]];
			}
			
			[AuxPorts addObject:[[Port alloc ]initWithType: RESOURCE withResource: LUMBER]];
			[AuxPorts addObject:[[Port alloc ]initWithType: RESOURCE withResource: BRICK]];
			[AuxPorts addObject:[[Port alloc ]initWithType: RESOURCE withResource: WOOL]];
			[AuxPorts addObject:[[Port alloc ]initWithType: RESOURCE withResource: ORE]];
			[AuxPorts addObject:[[Port alloc ]initWithType: RESOURCE withResource: GRAIN]];
			
			NSMutableArray* Ports = [[NSMutableArray alloc]init];
			
			while ([AuxPorts count]>0)  {
				
				int index = arc4random_uniform([AuxPorts count]);
				
				[Ports addObject:[AuxPorts objectAtIndex:index]];
				
				[AuxPorts removeObjectAtIndex:index];
				
			}
			
			//Coloca portos nos vertices
			
			VertexNode* aux;
			
			aux = [self.vertexes objectAtIndex:0];
			aux.port = [Ports objectAtIndex:0];
			aux = [self.vertexes objectAtIndex:1];
			aux.port = [Ports objectAtIndex:0];
			
			aux = [self.vertexes objectAtIndex:3];
			aux.port = [Ports objectAtIndex:1];
			aux = [self.vertexes objectAtIndex:4];
			aux.port = [Ports objectAtIndex:1];
			
			aux = [self.vertexes objectAtIndex:14];
			aux.port = [Ports objectAtIndex:2];
			aux = [self.vertexes objectAtIndex:15];
			aux.port = [Ports objectAtIndex:2];
			
			aux = [self.vertexes objectAtIndex:26];
			aux.port = [Ports objectAtIndex:3];
			aux = [self.vertexes objectAtIndex:37];
			aux.port = [Ports objectAtIndex:3];
			
			aux = [self.vertexes objectAtIndex:45];
			aux.port = [Ports objectAtIndex:4];
			aux = [self.vertexes objectAtIndex:46];
			aux.port = [Ports objectAtIndex:4];
			
			aux = [self.vertexes objectAtIndex:50];
			aux.port = [Ports objectAtIndex:5];
			aux = [self.vertexes objectAtIndex:51];
			aux.port = [Ports objectAtIndex:5];
			
			aux = [self.vertexes objectAtIndex:47];
			aux.port = [Ports objectAtIndex:6];
			aux = [self.vertexes objectAtIndex:48];
			aux.port = [Ports objectAtIndex:6];
			
			aux = [self.vertexes objectAtIndex:28];
			aux.port = [Ports objectAtIndex:7];
			aux = [self.vertexes objectAtIndex:38];
			aux.port = [Ports objectAtIndex:7];
			
			aux = [self.vertexes objectAtIndex:7];
			aux.port = [Ports objectAtIndex:8];
			aux = [self.vertexes objectAtIndex:17];
			aux.port = [Ports objectAtIndex:8];
			
		
	}
	
	
	return self;


}


-(id) initWithTable:(NSDictionary *)table{
	
	self = [super init];
	
	self.hexes = [[NSMutableArray alloc] init];
	self.vertexes = [[NSMutableArray alloc] init];
	self.edges = [[NSMutableArray alloc] init];
	self.deck = [[DevelopmentCards alloc] init];
	
	if(self){
		
		NSArray * resources = [table objectForKey:@"resources"];
		NSArray	* numbers = [table objectForKey:@"numbers"];
		NSArray * portTypes = [table objectForKey:@"portTypes"];
		NSArray * portResources = [table objectForKey:@"portResources"];
		
		// Declaracao dos HEX
		for(int i=0; i<19; i++){
			
			//inicializa os HEx e os coloca na posicao que serao mostrados.
			
			HexagonNode *aux = [[HexagonNode alloc] initWithResource:[[resources objectAtIndex:i] integerValue]];
			aux.number = [numbers[i] integerValue];
			
			if([numbers[i] integerValue] == 7){
				self.thief = aux;
			}
			
			aux.name = [NSString stringWithFormat:@"Hex%i", i];
			
			if(i<1)
				aux.position = CGPointMake(0, 0);
			if(i>=1 && i<7)
				aux.position = CGPointMake(0+133*cos((i-1)*M_PI/3), 0+133*sin((i-1)*M_PI/3));
			if(i>=7 && !(i%2))
				aux.position = CGPointMake(0+230*cos((i-7)*M_PI/6), 0+230*sin((i-7)*M_PI/6));
			else if(i>=7)
				aux.position = CGPointMake(0+266*cos((i-7)*M_PI/6), 0+266*sin((i-7)*M_PI/6));
			
			//Coloca uma skin nos Hex
			//Mudar esse codigo para colocar as tiles certas depois!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			SKLabelNode * numberLabel = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
			numberLabel.fontSize = 30;
			numberLabel.text = [[NSString alloc] initWithFormat:@"%d", aux.number];
			[aux addChild:numberLabel];
			
			[self.hexes addObject:aux];
		}
		
		
		
		
		//Declaracao dos Vertex
		for(int i=0; i<54; i++){
			
			VertexNode * newVertex = [[VertexNode alloc] init];
			newVertex.name = [[NSString alloc] initWithFormat:@"vertex%d",i];
			
			newVertex.port = [[Port alloc]init];
			newVertex.port.type = [[portTypes objectAtIndex:i] integerValue];
			newVertex.port.resource = [[portResources objectAtIndex:i] integerValue];
			
			[self.vertexes addObject:newVertex];
			
		}
		
		//Declaracao dos Edges
		for(int i=0; i<72; i++){
			EdgeNode * newEdge = [[EdgeNode alloc] init];
			newEdge.name = [[NSString alloc] initWithFormat:@"edge%d",i];
			[self.edges addObject:newEdge];
		}
		
		
		
		//Leitura do CSV dos Hexagonos
		NSString *path =[[NSBundle mainBundle] pathForResource:@"hexCSV" ofType:@".csv"];
		NSArray *csvHex = [FileReader createTableFromFile:path];
		
		
		
		//Relacionar os Vertex e os Edges com os Hexagonos
		for(int i=0; i<self.hexes.count; i++){
			HexagonNode* hex= self.hexes[i];
			
			NSDictionary* dictio = csvHex[i];
			
			NSArray* indexesVertices = [dictio objectForKey:@"Vertex"];
			
			for(NSString* stringIndex in indexesVertices){
				int index = [stringIndex intValue];
				[hex.vertexes addObject:[self.vertexes objectAtIndex:index]];
			}
			
			
			NSArray* indexesEdges = [dictio objectForKey:@"Edge"];
			
			for(NSString* stringIndex in indexesEdges){
				int index = [stringIndex intValue];
				[hex.edges addObject:[self.edges objectAtIndex:index]];
			}
			
		}
		
		
		//Ler CSV dos Vertex
		path =[[NSBundle mainBundle] pathForResource:@"verticeCSV" ofType:@".csv"];
		NSArray *csvVertex = [FileReader createTableFromFile:path];
		
		//Relacionar os Edges com os vertex
		
		for(int i=0; i<self.vertexes.count; i++){
			VertexNode* vertex= self.vertexes[i];
			
			NSDictionary* dictio = csvVertex[i];
			
			NSArray* indexEdges = [dictio objectForKey:@"Edge"];
			
			for(NSString* stringIndex in indexEdges){
				int index = [stringIndex intValue];
				if(index>=0)
					[vertex.edges addObject:[self.edges objectAtIndex:index]];
			}
			
		}
		
		for(VertexNode *vertex in self.vertexes){
			
			for(EdgeNode *edge in vertex.edges){
				[edge.vertexes addObject:vertex];
			}
		}
		
		for(HexagonNode *hex in self.hexes){
			
			for(int i = 0 ; i < 6 ; i++){
				// verificar esse cast
				((VertexNode *)[hex.vertexes objectAtIndex:i]).position =CGPointMake(hex.position.x+77*cos(M_PI/6+i*M_PI/3), hex.position.y+77*sin(M_PI/6+i*M_PI/3));
				
				((EdgeNode *)[hex.edges objectAtIndex:i]).position =CGPointMake(hex.position.x+77*pow(3, 0.5)/2*cos(i*M_PI/3), hex.position.y+77*pow(3, 0.5)/2*sin(i*M_PI/3));
				((EdgeNode *)[hex.edges objectAtIndex:i]).zRotation = i*M_PI/3;
			}
			
		}
		
		//cards
		
		NSArray * cards = [table objectForKey:@"deck"];
		self.deck.deck = [[NSMutableArray alloc] init];
		
		for(NSNumber * card in cards){
			
			[self.deck.deck addObject:card];
			
		}
		
	}
	
	
	return self;
	

}



-(BOOL) moveThiefToHexagon:(HexagonNode *)hex{
	
	if (hex !=self.thief) {
		self.thief = hex;
		self.thiefHasBeenMoved = YES;
		NSLog(@"thief moveu para:%f %f", self.thief.position.x, self.thief.position.y);
		return YES;
	}
	return NO;
}

@end
