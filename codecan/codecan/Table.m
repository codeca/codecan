//
//  Table.m
//  codecan
//
//  Created by Felipe Fujioka on 22/10/13.
//  Copyright (c) 2013 Codeca. All rights reserved.
//

#import "Table.h"

@implementation Table

-(id)init{
	
	self = [super init];
	
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
			HexagonNode *aux = [[HexagonNode alloc] init];
			
			aux.name = [NSString stringWithFormat:@"Hex%i", i];
			
			aux.resource = [[resources lastObject] integerValue];
			[resources removeLastObject];
			
			//TEMPORARIO
			
			SKLabelNode * res = [SKLabelNode labelNodeWithFontNamed:@"Chalkdust"];
			
			switch (aux.resource) {
				case DESERT:
					res.text = @"Desert";
					break;
				case WOOL:
					res.text = @"Wool";
					break;
				case BRICK:
					res.text = @"Brick";
					break;
				case GRAIN:
					res.text = @"Grain";
					break;
				case ORE:
					res.text = @"Ore";
					break;
				case LUMBER:
					res.text = @"Lumber";
					break;
				default:
					break;
			}
			
			[aux addChild:res];
			
			//TEMPORARIO END
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
			else
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = 7;
		}
		
		for(int i=1; i<7 ; i++){
			if([(HexagonNode *)[self.hexes objectAtIndex:i] resource] != DESERT){
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = [(NSNumber*)[numbers objectAtIndex:counter] integerValue];
				counter++;
			}
			else
				((HexagonNode *)[self.hexes objectAtIndex:i]).number = 7;
		}
		
		if([(HexagonNode *)[self.hexes objectAtIndex:0] resource] != DESERT)
			((HexagonNode *)[self.hexes objectAtIndex:0]).number = 11;
		else
			((HexagonNode *)[self.hexes objectAtIndex:0]).number = 7;

			
		
		
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
		
	}
	
	
	return self;


}

@end
