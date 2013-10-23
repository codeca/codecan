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
		
		
		// Declaracao dos HEX
		for(int i=0; i<19; i++){
			
			//inicializa os HEx e os coloca na posicao que serao mostrados.
			HexagonNode *aux = [[HexagonNode alloc] init];
			
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
		
		
		//Declaracao dos Vertex
		for(int i=0; i<54; i++){
			VertexNode * newVertex = [[VertexNode alloc] init];
			[self.vertexes addObject:newVertex];
			
		}
		
		//Declaracao dos Edges
		for(int i=0; i<72; i++){
			EdgeNode * newEdge = [[EdgeNode alloc] init];
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
