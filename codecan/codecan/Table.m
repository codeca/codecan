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
	
	if(self){
		//da orientacao que usaremos, temos os valores de x0 e y0;
		
		int x0=768/2;
		int y0 = 1024/2+44;
		
		
		// Declaracao dos HEX
		for(int i=0; i<19; i++){
			
			//inicializa os HEx e os coloca na posicao que serao mostrados.
			HexagonNode *aux = [[HexagonNode alloc] init];
			
			aux.name = [NSString stringWithFormat:@"Hex%i", i];
			
			if(i<1)
				aux.position = CGPointMake(x0, y0);
			if(i>=1 && i<7)
				aux.position = CGPointMake(x0+133*cos((i-1)*M_PI/3), y0+133*sin((i-1)*M_PI/3));
			if(i>=7 && !(i%2))
				aux.position = CGPointMake(x0+230*cos((i-7)*M_PI/6), y0+230*sin((i-7)*M_PI/6));
			else if(i>=7)
				aux.position = CGPointMake(x0+266*cos((i-7)*M_PI/6), y0+266*sin((i-7)*M_PI/6));
			
			//Coloca uma skin nos Hex
			//Mudar esse codigo para colocar as tiles certas depois!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			aux.texture = [SKTexture textureWithImageNamed:@"tile"];
			
			
			[self.hexes addObject:aux];
			
		}
		
		
		//Declaracao dos Vertex
		for(int i=0; i<54; i++){
			[self.vertexes addObject:[[VertexNode alloc] init]];
			
		}
		
		//Declaracao dos Edges
		for(int i=0; i<72; i++){
			[self.edges addObject:[[EdgeNode alloc] init]];
		}
		
		
		
		//Leitura do CSV dos Hexagonos
		NSString *path =[[NSBundle mainBundle] pathForResource:@"verticeCSV" ofType:@".csv"];
		NSArray *csvHex = [FileReader createTableFromFile:path];
		
		
		
		//Relacionar os Vertex e os Edges com os Hexagonos
		for(int i=0; i<self.hexes.count; i++){
			HexagonNode* hex= self.hexes[i];
			
			NSDictionary* dictio = csvHex[i];
			
			NSArray* indexesVertices = [dictio objectForKey:@"Vertices"];
			
			for(NSString* stringIndex in indexesVertices){
				int index = [stringIndex intValue];
				[hex.vertexes addObject:[self.vertexes objectAtIndex:index]];
			}
			
			
			NSArray* indexesEdges = [dictio objectForKey:@"Arestas"];
			
			for(NSString* stringIndex in indexesEdges){
				int index = [stringIndex intValue];
				[hex.edges addObject:[self.edges objectAtIndex:index]];
			}
			
		}
		
		
		//Ler CSV dos Vertex
		path =[[NSBundle mainBundle] pathForResource:@"verticeCSV" ofType:@".csv"];
		NSArray *csvVertex = [FileReader createTableFromFile:path];
		
		
		//Relacionar os Edges com os vertex
		
	}
	
	
	return self;


}

@end
