// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef USQUAD_H
#define	USQUAD_H

#include <uslsext/USMatrix2D.h>

//================================================================//
// USQuad
//================================================================//
class USQuad {
private:

	//----------------------------------------------------------------//
	u32		Intersect			( const USQuad& quad, USVec2D* buffer, u32 max ) const;
	bool	IsSeparatingAxis	( const USVec2D& e0, const USVec2D& e1, const USVec2D& e2, const USVec2D& e3 ) const;

public:

	USVec2D mV [ 4 ];

	//----------------------------------------------------------------//
	bool	Contains			( float x, float y ) const;
	void	GetBounds			( USRect& rect ) const;
	void	Init				( const USRect& rect );
	void	Init				( float x0, float y0, float x1, float y1 );
	bool	Intersect			( const USQuad& quad, USRect& result ) const;
	bool	Intersect			( const USRect& rect, USRect& result ) const;
	bool	Overlap				( const USQuad& quad ) const;
	bool	Overlap				( const USRect& rect ) const;
	void	Scale				( float xScale, float yScale );
	void	Transform			( const USMatrix2D& transform );
};

#endif